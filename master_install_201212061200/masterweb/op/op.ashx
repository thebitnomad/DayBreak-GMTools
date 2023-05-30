<%@ WebHandler Language="C#" Class="SOperationHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Text;
using Saturn.Tools.Master;
using Saturn.Tools.Master.Web;
using Saturn.Tools.Security;
using Saturn.Tools;
using Resources;

public class SOperationHandler : IHttpHandler, IRequiresSessionState
{
	public void ProcessRequest( HttpContext context )
	{
		/* 进行权限检查 */
		if( context.Session[SWebConfig.SESSION_KEY_CURRENT_USER] == null )
		{
			return;
		}

		SUserLoginInfo userInfo = context.Session[SWebConfig.SESSION_KEY_CURRENT_USER] as SUserLoginInfo;
		if( userInfo == null )
		{
			return;
		}

		if( context.Request.Params[SWebConfig.PARAM_OPERATION] != null )
		{
			context.Response.ContentType = "text/plain";
			string op = context.Request.Params[SWebConfig.PARAM_OPERATION];
			switch( op )
			{
				case SWebConfig.OP_OP_EXPORTNAMELIST:
					ProcessExportNameList( context );
					break;
				default:
					break;
			}
		}
	}

	public bool IsReusable
	{
		get
		{
			return false;
		}
	}

	/*
	 * 导出角色数据
	 */
	private void ProcessExportNameList( HttpContext context )
	{
		if( context.Request.Params[SWebConfig.PARAM_EXNAMELISTTYPE] == null )
		    return;

		try
		{
			if( !SWebUtil.CheckPrivilege( context.Session, SMasterSecObjDef.GM_DATAEXPORT_PATH, ( int )SBasePrivilege.Execute ) )
			{
				context.Response.Output.Write( StringDef.NotEnoughPrivilege );
				return;
			}

			int type = int.Parse( context.Request.Params[SWebConfig.PARAM_EXNAMELISTTYPE] );
			SNameEntry[] nameEntries	= null;
			string fileName				= string.Empty;
			switch( type )
			{
				case 0:
					nameEntries = SMaster.TheInstance.OperationManager.SvrCombineAgent.ExportRoleNameList( );
					fileName	= "RoleNameList.txt";
					break;
				case 1:
					nameEntries	= SMaster.TheInstance.OperationManager.SvrCombineAgent.ExportDelRoleNameList( );
					fileName	= "RoleNameList_Delete.txt";
					break;
				case 2:
					nameEntries = SMaster.TheInstance.OperationManager.SvrCombineAgent.ExportSocietyNameList( );
					fileName	= "SocietyNameList.txt";
					break;
			}

			byte[] data = Encoding.Default.GetBytes( GenTxtContent( nameEntries ) );

			context.Response.Clear( );
			context.Response.ClearHeaders( );
			context.Response.ClearContent( );
			context.Response.ContentEncoding = Encoding.UTF8;
			context.Response.AppendHeader( "Content-Disposition", "attachment; filename=" + fileName );
			//context.Response.AppendHeader( "Content-disposition", string.Format( "attachment; filename={0}", string.Format( "[{0}]{1}-{2}.sql", gg.Name, accountName, roleName ) ) );
			context.Response.ContentType = "application/octet-stream";
			context.Response.OutputStream.Write( data, 0, data.Length );
		}
		catch( Exception ex )
		{
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}
	}

	private string GenTxtContent( SNameEntry[] nameEntries )
	{
		if( nameEntries == null )
			return string.Empty;

		StringBuilder builder = new StringBuilder( );
		foreach( SNameEntry entry in nameEntries )
		{
			builder.Append( entry.ID );
			builder.Append( "\t" );
			builder.Append( entry.Name );
			builder.Append( SUtil.NEWLINE_WINDOWS );
		}

		return builder.ToString( );
	}
}