<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="security_userman, App_Web_userman.aspx.cecc3084" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" runat="Server">
	<script type="text/javascript">
		var msgTitle = '<%= Resources.StringDef.SystemName %>';
		var msgLoading = '<%= Resources.StringDef.Loading %>';
		var msgSaving = '<%= Resources.StringDef.Saving %>';
		var msgSubmitting = '<%= Resources.StringDef.Submitting %>';
		var removeUserConfirmMsgFormat = '<%= Resources.StringDef.MsgRemoveUserConfirmFormat %>';
		var removeUserConfirmTitle = '<%= Resources.StringDef.RemoveUser %>';
		var resetUserPassMsg = '<%= Resources.StringDef.NewPassword %>';
		var resetUserPassTitle = '<%= Resources.StringDef.ResetUserPass %>';
		var resetPassSuccessMsg = '<%= Resources.StringDef.ResetUserPassSuccess %>';
	</script>
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var showAddUserWin = function( ) {
				#{FormPanelAddUser}.reset( );
				#{TextFieldAddRestrictAddress}.setValue( '%' );
				#{WindowAddUser}.show( );
			};
			
			var addUser = function( ) {
				Ext.net.DirectMethods.AddUser( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ){
						if( result.Success ){
							#{WindowAddUser}.hide( );
							queryUser( );
						}
						else {
							if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
						}
					}
				});
			};
			
			var removeUser = function( ) {
				var grid = #{GridPanelUser};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( removeUserConfirmTitle, String.format( removeUserConfirmMsgFormat, record.data.UserName ), function( btn ){
					if( btn == "yes" ) {
						grid.getRowEditor( ).stopEditing( );
						Ext.net.DirectMethods.RemoveUser( record.data.Id, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ){
									#{StoreUserData}.remove( record );
									#{StoreUserData}.commitChanges( );
								}
								else{
									if( result.ErrorMessage )
										showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyUser = function( roweditor, obj, record, rowIndex ) {
				Ext.net.DirectMethods.ModifyUser( record.data.Id, record.data.RealName, record.data.Comment, record.data.AuthType, record.data.NoLogin, record.data.RestrictAddress, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSaving
					},
					success: function( result ){
						var editor = #{RowEditorUser};
						var store = #{StoreUserData};
						if( result.Success ){
							store.commitChanges( );
							editor.stopEditing( true );
						} else {
							store.rejectChanges( );
							editor.startEditing( rowIndex );
							if( result.ErrorMessage )
								showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var resetPass = function( ){
				var grid = #{GridPanelUser};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showPromptMsg( resetUserPassTitle, resetUserPassMsg, function( btn, msg ){
					if( btn == "ok" ) {
						grid.getRowEditor( ).stopEditing( );
						Ext.net.DirectMethods.ResetUserPass( record.data.Id, msg, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ) {
									showSuccessMsg( msgTitle, resetPassSuccessMsg );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
						
			var hideAddUserWin = function( ) {
				#{WindowAddUser}.hide( );
			};
			
			var renderAuthType = function( value, metadata, record, rowIndex, colIndex, store ) {
				var authTypeText = '';
				switch( eval( record.data.AuthType ) ) {
					case 0:
						authTypeText = msgAuthTypeLocal;
						break;
					case 1:
						authTypeText = msgAuthTypeDomain;
						break;
				}
				
				return authTypeText;
			};
			
			var queryUser = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingToolbarUser}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreUserData}.lastOptions ) {
					paramStart = #{StoreUserData}.lastOptions.params.start;
				}
				#{StoreUserData}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var getQueryParams = function( store, options ) {
				var userName = #{TextFieldQueryUserName}.getValue( );
				var realName = #{TextFieldQueryRealName}.getValue( );

				options.params.UserName = userName;
				options.params.RealName = realName;
			};
			
			var gridUserSelectionChange = function( el ) {
				#{TbarButtonRemoveUser}.setDisabled( el.getCount( ) < 1 );
				#{TbarButtonResetPass}.setDisabled( el.getCount( ) < 1 );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					queryUser( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="Server">
	<ext:Store ID="StoreUserData" runat="server" OnRefreshData="UserDataRefresh" RemoteSort="true" RemotePaging="true" AutoLoad="false">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelUser}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<SortInfo Field="UserName" Direction="ASC" />
		<Listeners>
			<BeforeLoad Fn="getQueryParams" />
		</Listeners>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="RealName" Mapping="RealName" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="NoLogin" Mapping="NoLogin" Type="Boolean" />
					<ext:RecordField Name="AuthType" Mapping="AuthType" Type="Int" />
					<ext:RecordField Name="RestrictAddress" Mapping="RestrictAddress" Type="String" />
					<ext:RecordField Name="GroupInfo" Mapping="GroupInfo" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="server">
				<Center>
					<ext:GridPanel ID="GridPanelUser" runat="server" StoreID="StoreUserData" AutoExpandColumn="GroupInfo"
						Border="false" MaskDisabled="false">
						<Plugins>
							<ext:RowEditor ID="RowEditorUser" runat="server" SaveText="<%$ Resources: StringDef, Update %>" CancelText="<%$ Resources: StringDef, Cancel %>" CommitChangesText="<%$ Resources: StringDef, RowEditCommitChanges %>" >
								<Listeners>
									<AfterEdit Fn="modifyUser" />
								</Listeners>
							</ext:RowEditor>
						</Plugins>
						<View>
							<ext:GridView ID="GridView1" runat="server" MarkDirty="true" />
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="TbarButtonAddUser" runat="server" Text="<%$ Resources:StringDef, AddUser %>" Icon="UserAdd" >
										<Listeners>
											<Click Fn="showAddUserWin" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="TbarButtonRemoveUser" runat="server" Text="<%$ Resources:StringDef, RemoveUser %>" Icon="UserDelete" Disabled="true" >
										<Listeners>
											<Click Fn="removeUser" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="TbarButtonResetPass" runat="server" Text="<%$ Resources:StringDef, ResetUserPass %>" Icon="Reload" Disabled="true" >
										<Listeners>
											<Click Fn="resetPass" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarFill />
									<ext:TextField ID="TextFieldQueryUserName" runat="Server" EmptyText="<%$ Resources:StringDef, UserName %>" Width="80">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:ToolbarSpacer />
									<ext:TextField ID="TextFieldQueryRealName" runat="Server" EmptyText="<%$ Resources:StringDef, RealName %>" Width="80">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:ToolbarSpacer />
									<ext:Button ID="TbarButtonRefresh" runat="server" Text="<%$ Resources:StringDef, Query %>" Icon="Magnifier" >
										<Listeners>
											<Click Handler="queryUser( true );" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingToolbarUser" runat="server" PageSize="50" StoreID="StoreUserData" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" >
								<Listeners>
									<SelectionChange Fn="gridUserSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn />
								<ext:Column ColumnID="Id" Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="50" Sortable="true" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, UserName %>" DataIndex="UserName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RealName %>" DataIndex="RealName" Width="100">
									<Editor>
										<ext:TextField ID="TextFieldRealName" runat="server" />
									</Editor>
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" >
									<Editor>
										<ext:TextField ID="TextFieldComment" runat="server" />
									</Editor>
								</ext:Column>
								<ext:BooleanColumn Header="<%$ Resources:StringDef, LoginState %>" DataIndex="NoLogin" Align="Center" FalseText="<%$ Resources:StringDef, LoginStateFalseDisplayMessage %>" TrueText="<%$ Resources:StringDef, LoginStateTrueDisplayMessage %>" Width="75" >
									<%--<Renderer Fn="loginStateRenderer" />--%>
									<Editor>
										<%--<ext:ComboBox ID="ComboBoxLoginState" runat="server" Shadow="Drop" Mode="Local" TriggerAction="All" ForceSelection="true" >
											<Items>
												<ext:ListItem Text="Allow" Value="true" />
												<ext:ListItem Text="Deny" Value="false" />
											</Items>
											<Listeners>
												<Render Fn="loginStateRenderer" />
											</Listeners>
										</ext:ComboBox>--%>
										<ext:Checkbox ID="CheckboxNoLogin" runat="server" BoxLabel="<%$ Resources:StringDef, Allow %>" AnchorHorizontal="100%" />
									</Editor>
								</ext:BooleanColumn>
								<ext:Column Header="<%$ Resources:StringDef, RestrictAddress %>" DataIndex="RestrictAddress" Align="Center" >
									<Editor>
										<ext:TextField ID="TextFieldRestrictAddress" runat="server" />
									</Editor>
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, GroupInfo %>" DataIndex="GroupInfo" Align="Center" Sortable="false" >
									<Editor>
										<ext:Hidden runat="Server" ></ext:Hidden>
									</Editor>
								</ext:Column>
							</Columns>
						</ColumnModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<ext:Window ID="WindowAddUser" runat="server" Resizable="false" Collapsible="true"
		Width="500" AutoHeight="true" Title="<%$ Resources:StringDef, UserInfo %>" CloseAction="Hide"
		Hidden="true" AnimateTarget="#{TbarButtonAddUser}" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelAddUser" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="150" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldAddUserName" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, UserName %>"
						AllowBlank="false" BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>" MsgTarget="Side">
					</ext:TextField>
					<ext:TextField ID="TextFieldAddRealName" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, RealName %>"
						BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldAddComment" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, Comment %>"
						BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldAddPassword" runat="server" AnchorHorizontal="80%" InputType="Password"
						FieldLabel="<%$ Resources:StringDef, Password %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldAddRestrictAddress" runat="server" AnchorHorizontal="80%"
						FieldLabel="<%$ Resources:StringDef, RestrictAddress %>" AllowBlank="false" BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>"
						MsgTarget="Side">
					</ext:TextField>
					<ext:Checkbox ID="CheckboxAddLoginState" FieldLabel="<%$ Resources:StringDef, LoginState %>" runat="server" AnchorHorizontal="80%" BoxLabel="<%$ Resources:StringDef, Allow %>" Checked="true">
					</ext:Checkbox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonAddUser" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="addUser" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="ButtonAddCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Fn="hideAddUserWin" />
				</Listeners>
			</ext:Button>
		</Buttons>
		<Listeners>
			<Show Handler="#{TextFieldAddUserName}.focus( );" Delay="50" />
		</Listeners>
	</ext:Window>
	<ext:ToolTip ID="ToolTipQueryUserName" runat="server" Target="#{TextFieldQueryUserName}" Anchor="top" Html="<%$ Resources:StringDef, UserName %>" />
	<ext:ToolTip ID="ToolTipQueryRealName" runat="server" Target="#{TextFieldQueryRealName}" Anchor="top" Html="<%$ Resources:StringDef, RealName %>" />
</asp:Content>
