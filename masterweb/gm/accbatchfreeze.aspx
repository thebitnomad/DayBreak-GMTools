<%@ page language="C#" autoeventwireup="true" maintainscrollpositiononpostback="true" masterpagefile="~/common/main.master" inherits="gm_accbatchfreeze, App_Web_accbatchfreeze.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrList" Src="~/common/svrlist.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	
	<script type="text/javascript">
		var msgTitle						= '<%= Resources.StringDef.SystemName %>';
		var msgCannotBeNullFormat			= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgBatchFreezeAccount			= '<%= Resources.StringDef.MsgBatchFreezeAccount %>';
		var msgOpSuc						= '<%= Resources.StringDef.OpSuc %>';
		var msgSubmitting					= '<%= Resources.StringDef.Submitting %>';
		var msgAccountExecuteDoneFreeze		= '<%= Resources.StringDef.AccountExecuteSucFreeze %>';
		var msgAccountExecuteFailureFreeze	= '<%= Resources.StringDef. AccountExecuteFailureFreeze%>';
		var msgReason						= '<%= Resources.StringDef.Reason %>';
		var msgAccount						= '<%= Resources.StringDef.Account %>';
		var msgCurrentProgress				= '<%= Resources.StringDef.CurrentProgress %>';
		var msgColon						= '<%= Resources.StringDef.Colon %>';
		var msgPleaseSelectOneGameGroup		= '<%= Resources.StringDef.MsgPleaseSelectOneGameGroup %>';
	</script>
	
	<ext:XScript ID="XScript" runat="Server">
		<script type="text/javascript">
			
			var m_accIdBatch	= '';
			var m_nologin		= true;
			var m_timeSeconds	= -1;
			var m_gameId;
			var m_allAccCounts;
			var m_intervalId;
			
			
			var btnBatchFreezeAccount = function( ) {
				
				var type		= 0;
				var allAccounts = #{TextAccounts}.getValue( );
				var reason		= #{FieldReason}.getValue( );
				var svrId		= selectGameGroup( );

				if( #{RadioRoleAccount}.checked ) {
					type = 0;
					svrId = -1;
				}
				else if( #{RadioRoleGUID}.checked ) {
					type = 1;
				}
				
				if( allAccounts.replace( /^\s*/, '').length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgAccount ) );
					return;
				}
				if( reason.replace( /^\s*/, '').length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgReason ) );
					return;
				}
				
				var result = showConfirmMsg( msgTitle, msgBatchFreezeAccount, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.FreezeAccount( svrId, allAccounts, m_accIdBatch, !m_nologin, reason, m_timeSeconds, m_gameId, type, {
							eventMask:	{
								showMask : true,
								minDelay : 200,
								msg		 : msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryBatchFreezeAccount( );
									m_intervalId = setInterval( queryBatchFreezeAccount, 2000 );
									m_allAccCounts = result.Result.AllAccountCounts;
								}else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var updateProgressBar = function( value, progress, btn, count, callback ) {
				if( value > count ) {
					btn.setDisabled( false );
					callback( );
				}else{
					if( count == 0 ) {
						showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgAccount ) );
						return;
					}
					progress.updateProgress( value / count, String.format( '<span>{0}{1}{2}</span>', msgCurrentProgress, msgColon, ( value + '/' + count ) ) );
					if( value == count ) {
						btn.setDisabled( false );
						clearInterval( m_intervalId );
					}
				}
			};
			
			var progressRun = function( progress, btn, count, progressVal, callback ) {
				btn.setDisabled( true );
				updateProgressBar( progressVal, progress, btn, count, callback );
			};
			
			var showFreezeAccProgressInfo = function( progress, btn ) {
			
				progress.show( );
				var progressBarVal = #{StoreBatchFreezeAcc}.totalLength;
				progressRun( progress, btn, m_allAccCounts,progressBarVal, function( ) {
				} );
			};
			
			var queryBatchFreezeAccount = function( reset, callback ) {
				
				var paramStart		= 0;
				var paramLimit		= #{PagingToolBarBatchFreezeAccount}.pageSize;
				var progress		= #{ProgressBarBatchFreezeAcc};
				var btn				= #{BtnBatchFreezeAccount};
				
				if( #{StoreBatchFreezeAcc}.lastOptions ) {
					paramStart = #{StoreBatchFreezeAcc}.lastOptions.params.start;
				}

				#{StoreBatchFreezeAcc}.load( {
					params : { start: paramStart, limit: paramLimit },
					callback : function( ) {
						#{GridPanelBatchFreezeAccount}.setVisible( true );
						showFreezeAccProgressInfo( progress, btn );
					}	
				} );
			};
			
			var renderAccountState = function( value, metadata, record, rowIndex, colIndex, store ) {
			
				if( value == false ) {
					metadata.css = 'accfail';
					return msgAccountExecuteFailureFreeze;
				}else if( value == true ) {
					metadata.css = 'accsuc';
					return msgAccountExecuteDoneFreeze;
				}
			};
			
			var selectRadioChange = function( ) {
				
				if( #{RadioGroupType}.getValue( ).inputValue == 1 ) {
					#{ComboGameGroup}.setDisabled( false );
					#{StoreGameGroup}.reload( );
				}else{
					#{ComboGameGroup}.setDisabled( true );
				}
			};			
			
			var selectGameGroup = function ( ) {
				return #{ComboGameGroup}.getValue( );
			};
			
		</script>
	</ext:XScript>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	
	<ext:Store ID="StoreBatchFreezeAcc" runat="Server" RemoteSort="false" RemotePaging="true" AutoLoad="false" OnRefreshData="StoreBatchFreezeAccountRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelBatchFreezeAccount}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="ErrorMessage" Mapping="ErrorMessage" Type="String"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreGameGroup" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="GameGroupRefresh" >
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:FormPanel ID="FormPanelAccBatchFreeze" runat="Server" LabelAlign="Right" LabelWidth="200"  Title="<%$ Resources:StringDef, AccFreezeCondition %>"
				Height="300" Width="1000" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px" StyleSpec="margin:10px;"  >
				<Items>
					<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, Type %>">
						<Items>
							<ext:RadioGroup ID="RadioGroupType" runat="Server" Width="500">
								<Items>
									<ext:Radio ID="RadioRoleAccount" runat="Server" BoxLabel="<%$ Resources:StringDef, RoleAccount %>" Checked="true" StyleSpec="border-right:1px;"/>
									<ext:Radio ID="RadioRoleGUID" runat="Server" BoxLabel="<%$ Resources:StringDef, RoleGUID %>" InputValue="1" StyleSpec="border-left:1px;" />
								</Items>
								<Listeners>
									<Change Fn="selectRadioChange" />
								</Listeners>
							</ext:RadioGroup>
							<ext:ComboBox ID="ComboGameGroup" StoreID="StoreGameGroup" runat="server" LazyInit="false" ValueField="Id" Editable="false"
								DisplayField="Name" ForceSelection="true" Mode="Local" Width="215" Disabled="true" StyleSpec="border-right:1px;">
								<Listeners>
									<Select Fn="selectGameGroup" />
								</Listeners>
							</ext:ComboBox>
						</Items>
					</ext:CompositeField>
					<ext:TextArea ID="TextAccounts" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, RoleAccount %>" Height="150" AutoScroll="true"
						Note="<%$ Resources:StringDef, MsgRoleAccountNote %>" >
					</ext:TextArea>
					<ext:ComboBox ID="FieldReason" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, Reason %>" Editable="true" ForceSelection="false">
					<Items>
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason1 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason2 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason3 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason4 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason5 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason6 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason7 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason8 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason9 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason10 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason11 %>" />
						<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason12 %>" />
					</Items>
				</ext:ComboBox>
				</Items>
				<Buttons>
					<ext:Button ID="BtnBatchFreezeAccount" runat="Server" Text="<%$ Resources:StringDef, BatchFreeze %>">
						<Listeners>
							<Click Fn="btnBatchFreezeAccount" />
						</Listeners>
					</ext:Button>
				</Buttons>
			</ext:FormPanel>
			
			<ext:GridPanel ID="GridPanelBatchFreezeAccount" runat="Server" Border="true" Width="1000" Height="450" StyleSpec="margin:10px;" 
				Margins="10px 10px 10px 10px" Hidden="true" AutoExpandColumn="ErrorMessage" StoreID="StoreBatchFreezeAcc" AutoScroll="true" >
				<View>
					<ext:GridView runat="Server">
						<CustomConfig>
							<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
						</CustomConfig>
					</ext:GridView>
				</View>
				<ColumnModel>
					<Columns>
						<ext:RowNumbererColumn>
							<Renderer Handler=" return ''; " />
						</ext:RowNumbererColumn>
						<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" Width="200" Sortable="false">
						</ext:Column>
						<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="150" Sortable="false">
						</ext:Column>
						<ext:Column Header="<%$ Resources:StringDef, ErrorMessage %>" DataIndex="ErrorMessage" Sortable="false">
						</ext:Column>
					</Columns>
				</ColumnModel>
				<BottomBar>
					<ext:PagingToolbar ID="PagingToolBarBatchFreezeAccount" runat="Server" PageSize="100">
						<Items>
							<ext:ToolbarSeparator />
							<ext:ProgressBar ID="ProgressBarBatchFreezeAcc" runat="Server" Width="400" Hidden="true" >
							</ext:ProgressBar>
						</Items>
					</ext:PagingToolbar>
				</BottomBar>
				<SelectionModel>
					<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
					</ext:RowSelectionModel>
				</SelectionModel>
			</ext:GridPanel>
		</Items>
	</ext:Viewport>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
