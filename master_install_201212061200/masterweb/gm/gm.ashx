<%@ WebHandler Language="C#" Class="SGMHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Text;
using Saturn.Tools.Master;
using Saturn.Tools.Master.Web;
using Saturn.Tools.Security;
using Saturn.Tools;
using Resources;

public class SGMHandler : IHttpHandler, IRequiresSessionState
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
				case SWebConfig.GM_OP_EXPORTROLEDATA:
					ProcessExportRoleData( context );
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
	private void ProcessExportRoleData( HttpContext context )
	{	
		if( context.Request.Params[SWebConfig.PARAM_ROLENAME] == null )
		    return;

		if( context.Request.Params[SWebConfig.PARAM_GAMEGROUPID] == null )
		    return;

		try
		{
			if( !SWebUtil.CheckPrivilege( context.Session, SMasterSecObjDef.GM_DATAEXPORT_PATH, ( int )SBasePrivilege.Execute ) )
			{
				context.Response.Output.Write( StringDef.NotEnoughPrivilege );
				return;
			}

			string roleName	= context.Request.Params[SWebConfig.PARAM_ROLENAME];
			int ggId		= int.Parse( context.Request.Params[SWebConfig.PARAM_GAMEGROUPID] );
			
			SGameGroup gg = SMaster.TheInstance.SvrManager.GetGameGroup( ggId );
			if( gg == null )
				return;

			string accountName;
			string sqlText = SMaster.TheInstance.CustomerServiceMgr.ExportRoleData( gg, roleName, out accountName );

			byte[] data = Encoding.UTF8.GetBytes( sqlText );

			context.Response.Clear( );
			context.Response.ClearHeaders( );
			context.Response.ClearContent( );
			context.Response.ContentEncoding = Encoding.UTF8;
			context.Response.AppendHeader( "Content-disposition", string.Format( "attachment; filename={0}", string.Format( "[{0}]{1}-{2}.sql", gg.Name, accountName, roleName ) ) );
			context.Response.ContentType = "application/octet-stream";
			context.Response.OutputStream.Write( data, 0, data.Length );
		}
		catch( Exception ex )
		{
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}
	}
}