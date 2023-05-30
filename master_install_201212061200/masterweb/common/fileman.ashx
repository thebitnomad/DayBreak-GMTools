<%@ WebHandler Language="C#" Class="SFileManHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.IO;
using System.Text;
using Saturn.Tools.Master;
using Saturn.Tools.Master.Web;
using Saturn.Tools.Security;
using Saturn.Tools;
using Resources;

public class SFileManHandler : IHttpHandler, IRequiresSessionState
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
				case SWebConfig.COMMON_FILEDOWNLOAD:
					ProcessFileDownload( context );
					break;
				default:
					break;
			}
		}
	}
 
    public bool IsReusable {
        get {
            return false;
        }
    }

	/*
	 * 下载文件
	 */
	private void ProcessFileDownload( HttpContext context )
	{
		if( context.Request.Params[SWebConfig.PARAM_UPLOADTYPE] == null )
			return;

		if( context.Request.Params[SWebConfig.PARAM_FILEPATH] == null )
			return;

		try
		{
			if( !SWebUtil.CheckPrivilege( context.Session, SMasterSecObjDef.OPERATION_CLTUPDATE_PATH, ( int )SBasePrivilege.Execute ) )
			{
				//context.Response.Output.Write( "<html><body><script type='text/javascript'>window.alert('{0}')</script></body></html>", StringDef.NotEnoughPrivilege );
				context.Response.Output.Write( StringDef.NotEnoughPrivilege );
				return;
			}
			
			int uploadType;
			if( !int.TryParse( context.Request.Params[SWebConfig.PARAM_UPLOADTYPE], out uploadType ) )
				return;

			string dir = SWebUtil.GetFileUploadDir( uploadType );
			if( dir == null )
				return;
			
			string fileRelPath = context.Request.Params[SWebConfig.PARAM_FILEPATH];
			if( fileRelPath.StartsWith( "." ) || fileRelPath.StartsWith( ".." ) )
				return;

			string filePath = dir + fileRelPath;
			if( !File.Exists( filePath ) )
				return;
			
			context.Response.Clear( );
			context.Response.ClearHeaders( );
			context.Response.ClearContent( );
			context.Response.HeaderEncoding = Encoding.Default;
			context.Response.ContentEncoding = Encoding.UTF8;
			context.Response.AppendHeader( "Content-disposition", string.Format( "attachment; filename={0}", SUtil.GetFileName( fileRelPath ) ) );
			context.Response.ContentType = "application/octet-stream";
			context.Response.TransmitFile( filePath );
		}
		catch( Exception ex )
		{
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}
	}
}
