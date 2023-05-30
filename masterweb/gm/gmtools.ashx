<%@ WebHandler Language="C#" Class="SGMTools" %>

using System;
using System.Web;
using Saturn.Tools;
using Saturn.Tools.Master;
using Saturn.Tools.GMAgent;
using System.Linq;
using System.Text;
using Saturn.Tools.GameData.Daybreak;

public class SGMTools : IHttpHandler {

	private const string OPUSER_ERATING			= "eRating";
	
	public void ProcessRequest( HttpContext context )
	{
		bool validAddress = false;
		foreach( string ipAddr in SMasterSystemVar.Current.GMToolsAPIAddresses )
		{
			if( SUtil.CheckIPAddress( context.Request.UserHostAddress, ipAddr ) )
			{
				validAddress = true;
				break;
			}
		}

		if( !validAddress )
		{
			SUtil.OutputDebugLog( "SGMTools request refuse due to invalid address : " + context.Request.UserHostAddress );
			SMasterUtil.DebugLog( "SGMTools request refuse due to invalid address : " + context.Request.UserHostAddress );

			return;
		}
		
		string action = SUtil.GetFileName( context.Request.Path );
		switch( action )
		{
			case "KickRole":
				KickRole( context );
				break;
			case "FreezeAccount":
				FreezeAccount( context );
				break;
		}
	}

	private void KickRole( HttpContext context )
	{
		SLineKongGMToolsResult rst = new SLineKongGMToolsResult( );
		
		try
		{
			int gateId	= int.Parse( context.Request.Params["gateway_id"] );
			int gameId	= int.Parse( context.Request.Params["game_id"] );
			int roleId	= int.Parse( context.Request.Params["role_id"] );

			SGameGroup[] ggs = SMaster.TheInstance.SvrManager.GameGroups.Where( gg => gg.CoreProcess != null && gg.CoreProcess.SvrConfig != null && gg.CoreProcess.SvrConfig.PaymentGameId == gameId && gg.CoreProcess.SvrConfig.PaymentGateId == gateId ).ToArray( );
			if( ggs == null || ggs.Length == 0 )
			{
				rst.Result = SLineKongGMResult.E_ERROR;
			}
			else
			{
				string accountInfo	= string.Empty;
				string roleNameInfo	= string.Empty;
				int accId			= 0;
				
				SGameGroup gg = ggs[0];
				try
				{
					int total;
					SRoleInfo[] roleInfos = SMaster.TheInstance.CustomerServiceMgr.QueryRoleBaseInfo( gg, null, false, null, false, -1, roleId, null, null, null, false, -1, -1, out total );
					if( total > 0 && roleInfos != null && roleInfos.Length > 0 )
					{
						accountInfo		= roleInfos[0].Account;
						roleNameInfo	= roleInfos[0].RoleName;
						accId			= ( int )roleInfos[0].AccID;
					}
				}
				catch( Exception ex )
				{
					SUtil.OutputDebugLog( ex.ToString( ) );
					SMasterUtil.DebugLog( ex.ToString( ) );
				}
				
				if( SMaster.TheInstance.CustomerServiceMgr.KickRole( ggs[0].Id, accId, accountInfo, roleNameInfo, string.Empty, OPUSER_ERATING ) )
					rst.Result = SLineKongGMResult.S_SUCCESS;
				else
					rst.Result = SLineKongGMResult.E_ERROR;
			}
		}
		catch( Exception ex )
		{
			rst.Result = SLineKongGMResult.E_ERROR;
			
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}

		SendResponse( context, rst );
	}

	private void FreezeAccount( HttpContext context )
	{
		SLineKongGMToolsResult rst = new SLineKongGMToolsResult( );
		
		try
		{
			int gateId	= int.Parse( context.Request.Params["gateway_id"] );
			int gameId	= int.Parse( context.Request.Params["game_id"] );
			int accId	= int.Parse( context.Request.Params["user_id"] );

			SGameGroup[] ggs = SMaster.TheInstance.SvrManager.GameGroups.Where( gg => gg.CoreProcess != null && gg.CoreProcess.SvrConfig != null && gg.CoreProcess.SvrConfig.PaymentGameId == gameId && gg.CoreProcess.SvrConfig.PaymentGateId == gateId ).ToArray( );
			if( ggs == null || ggs.Length == 0 )
			{
				rst.Result = SLineKongGMResult.E_ERROR;
			}
			else
			{
				string accountInfo	= string.Empty;
				string roleNameInfo	= string.Empty;
				
				SGameGroup gg = ggs[0];
				try
				{
					int total;
					SRoleInfo[] roleInfos = SMaster.TheInstance.CustomerServiceMgr.QueryRoleBaseInfo( gg, null, false, null, false, accId, -1, null, null, null, false, -1, -1, out total );
					if( total > 0 && roleInfos != null && roleInfos.Length > 0 )
					{
						accountInfo		= roleInfos[0].Account;
					}
				}
				catch( Exception ex )
				{
					SUtil.OutputDebugLog( ex.ToString( ) );
					SMasterUtil.DebugLog( ex.ToString( ) );
				}
				
				if( SMaster.TheInstance.CustomerServiceMgr.KickRole( ggs[0].Id, accId, accountInfo, roleNameInfo, string.Empty, OPUSER_ERATING ) )
					rst.Result = SLineKongGMResult.S_SUCCESS;
				else
					rst.Result = SLineKongGMResult.E_ERROR;
			}
		}
		catch( Exception ex )
		{
			rst.Result = SLineKongGMResult.E_ERROR;
			
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}

		SendResponse( context, rst );
	}

	private void SendResponse( HttpContext context, SLineKongGMToolsResult rst )
	{
		try
		{
			byte[] data = Encoding.UTF8.GetBytes( rst.GetCommonResponse( ) );

			context.Response.ContentType = "text/plain";
			context.Response.ContentEncoding = Encoding.UTF8;
			context.Response.OutputStream.Write( data, 0, data.Length );
		}
		catch( Exception ex )
		{
			SUtil.OutputDebugLog( ex.ToString( ) );
			SMasterUtil.DebugLog( ex.ToString( ) );
		}
	}
	
	public bool IsReusable
	{
		get
		{
			return false;
		}
	}
}