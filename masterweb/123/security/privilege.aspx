<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="security_privilege, App_Web_privilege.aspx.cecc3084" theme="default" %>

<asp:Content ID="ContentHeader" ContentPlaceHolderID="HeaderHolder" runat="Server">
	<script type="text/javascript">
		var msgTitle = '<%= Resources.StringDef.SystemName %>';
		var msgLoading = '<%= Resources.StringDef.Loading %>';
		var msgSaving = '<%= Resources.StringDef.Saving %>';
		var msgSubmitting = '<%= Resources.StringDef.Submitting %>';
		var successMsg = '<%= Resources.StringDef.PrivilegeSaveSuccess %>';
		var operatorTitle = '<%= Resources.StringDef.UserOrGroup %>';
		var privilegeTitle = '<%= Resources.StringDef.Privilege %>';
		var removeOpPrivilegeConfirmMsgFormat = '<%= Resources.StringDef.RemoveOperatorPrivilegeConfirmMsgFormat %>';
		var removeOperatorPrivilegeErrorMsgFormat = '<%= Resources.StringDef.RemoveOperatorPrivilegeErrorMsgFormat %>';
	</script>
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var showCurrPriOperators = function( selectionModel, node ) {
				Ext.net.DirectMethods.LoadOperatorInfo( node.id, {
					eventMask: {
						showMask: true,
						msg: msgLoading,
						target: "customtarget",
						customTarget: "ctl00_ContentHolder_GridPanelOperators"
					},
					success: function( result ) {
						if( result.Success ) {
							#{TbarButtonAddOperator}.setDisabled( false );
							#{GridPanelOperators}.setTitle( operatorTitle + " - " + node.text );
							if( #{StoreOperator}.data.items.length > 0 ) {
								#{GridPanelOperators}.getSelectionModel( ).selectRow( 0 );
							}
						}
						else {
							if( result.ErrorMessage )
								showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var operatorSelChanged = function( el ) {
				/* Set TbarButtonRemoveOperator state */
				#{TbarButtonRemoveOperator}.setDisabled( el.getCount( ) < 1 );
				
				/* Set CbgPrivilege state */
				var cbg = #{CbgPrivilege};
				cbg.setDisabled( el.getCount( ) < 1 );
								
				/* Set save button state */
				#{TbarButtonSave}.setDisabled( true );
				
				var record = el.getSelected( );
				
				/* Set Privilege Panel's title */
				if( cbg.disabled ) {
					#{PanelPrivilege}.setTitle( privilegeTitle );
				} else {
					#{PanelPrivilege}.setTitle( privilegeTitle + " - " + record.data.Name );
				}
				
				for( var nLoopCount = 0; nLoopCount < cbg.items.items.length; ++nLoopCount ) {
					var checkbox = cbg.items.items[nLoopCount];
					checkbox.suspendEvents( false );
					if( cbg.disabled ) {
						checkbox.reset( );
					} else {
						var pri = eval( checkbox.tag );
						if( pri == 0 && record.data.Privilege == 0 ) {						
							/* NoAccess */
							checkbox.setValue( true );
						} else {
							/* Inherit */
							if( pri == 1 ) {
								checkbox.setDisabled( !record.data.Inherit );
							}
							
							checkbox.setValue( ( pri & record.data.Privilege ) > 0 );
						}
					}
					checkbox.resumeEvents( );
				}
			};
			
			var cbPrivilegeChecked = function( el, checked ) {
				#{TbarButtonSave}.setDisabled( false );
				
				if( checked ) {
					var cbg = #{CbgPrivilege};
					var pri = eval( el.tag );
					if( pri == 0 || pri == 1 ) {
						/* NoAccess or Inherit */
						for( var nLoopCount = 0; nLoopCount < cbg.items.items.length; ++nLoopCount ) {
							var checkbox = cbg.items.items[nLoopCount];
							var checkPri = eval( checkbox.tag );
							if( checkPri != pri ) {
								checkbox.suspendEvents( false );
								checkbox.reset( );
								checkbox.resumeEvents( );
							}
						}
					} else {
						for( var nLoopCount = 0; nLoopCount < cbg.items.items.length; ++nLoopCount ) {
							var checkbox = cbg.items.items[nLoopCount];
							var checkPri = eval( checkbox.tag );
							if( checkPri == 0 || checkPri == 1 ) {
								checkbox.suspendEvents( false );
								checkbox.reset( );
								checkbox.resumeEvents( );
							}
						}
					}
				}
			};
			
			var showAddOperatorWin = function( ) {
				Ext.net.DirectMethods.LoadUserAndGroup( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowAddOperator}.show( );
						}
						else {
							if( result.ErrorMessage )
								showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var addOperator = function( ) {
				var targetId = #{TreePanelPrivilege}.getSelectionModel( ).getSelectedNode( ).id;
				var operatorId = #{ComboUserAndGroup}.getValue( );
				
				Ext.net.DirectMethods.AddOperator( eval( targetId ), eval( operatorId ), {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowAddOperator}.hide( );
						}
						else {
							if( result.ErrorMessage )
								showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var removeOperator = function( ) {
				var targetNode = #{TreePanelPrivilege}.getSelectionModel( ).getSelectedNode( );
				var targetId = targetNode.id;
				var operatorRecord = #{GridPanelOperators}.getSelectionModel( ).getSelected( );
				var operatorId = operatorRecord.data.Id;
				
				var result = showConfirmMsg( msgTitle, String.format( removeOpPrivilegeConfirmMsgFormat, operatorRecord.data.Name, targetNode.text ), function( btn ){
					if( btn == "yes" ) {
						if( operatorRecord.data.Inherit ) {
							showErrMsg( msgTitle, String.format( removeOperatorPrivilegeErrorMsgFormat, operatorRecord.data.Name ) );
						} else {
							Ext.net.DirectMethods.RemoveOperator( eval( targetId ), eval( operatorId ), {
								eventMask: {
									showMask: true,
									minDelay: 200,
									msg: msgSubmitting
								},
								success: function( result ) {
									if( result.Success ) {
									}
									else {
										if( result.ErrorMessage )
											showErrMsg( msgTitle, result.ErrorMessage );
									}
								}
							});
						}
					}
				});
			};
			
			var savePrivilege = function( ) {
				var targetId = #{TreePanelPrivilege}.getSelectionModel( ).getSelectedNode( ).id;
				var selRecord = #{GridPanelOperators}.getSelectionModel( ).getSelected( );
				var operatorId = selRecord.data.Id;
				
				/* Remember this method that get GridPanel's selected index. */
				var selRowIndex = #{GridPanelOperators}.store.indexOf( selRecord );
				
				var cbg = #{CbgPrivilege};
				var privilege = 0;
				for( var nLoopCount = 0; nLoopCount < cbg.items.items.length; ++nLoopCount ) {
					var checkbox = cbg.items.items[nLoopCount];
					if( checkbox.checked ) {
						var checkValue = eval( checkbox.tag );
						privilege |= checkValue;
					}
				}
				
				Ext.net.DirectMethods.SavePrivilege( eval( targetId ), eval( operatorId ), privilege, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSaving
					},
					success: function( result ) {
						if( result.Success ) {
							#{GridPanelOperators}.getSelectionModel( ).selectRow( selRowIndex );
						}
						else {
							if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
								showCurrPriOperators( null, #{TreePanelPrivilege}.getSelectionModel( ).getSelectedNode( ) );
							}
						}
					}
				});
			};
			
			var priNodeLoad = function( node ) {
				Ext.net.DirectMethods.NodeLoad( node.id, {
					success: function( result ) {
						var data = eval( "(" + result.Result + ")" );
						node.loadNodes( data );
					}
				} );
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="Server">
	<ext:Store ID="StoreOperator" runat="server">
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Type="int" />
					<ext:RecordField Name="Name" Type="String" />
					<ext:RecordField Name="Comment" Type="String" />
					<ext:RecordField Name="Type" Type="String" />
					<ext:RecordField Name="Privilege" Type="Int" />
					<ext:RecordField Name="Inherit" Type="Boolean" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Store ID="StoreUserAndGroup" runat="server" >
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Type="int" />
					<ext:RecordField Name="Name" Type="String" />
					<ext:RecordField Name="Comment" Type="String" />
					<ext:RecordField Name="Type" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:ColumnLayout ID="ColumnLayout1" runat="server" Split="true" FitHeight="true">
				<Columns>
					<ext:LayoutColumn ColumnWidth="0.60">
						<ext:TreeGrid ID="TreePanelPrivilege" runat="server" Height="400" Title="<%$ Resources:StringDef, SystemScope %>"
							Animate="true" Border="false" StyleSpec="border-right:1px solid #8DB2E3;padding:0px;"
							RootVisible="false" AutoExpandColumn="Desc" EnableSort="false">
							<Columns>
								<ext:TreeGridColumn Header="<%$ Resources:StringDef, Name %>" Width="200" DataIndex="Name" />
								<ext:TreeGridColumn Header="<%$ Resources:StringDef, Desc %>" Width="400" DataIndex="Desc" />
							</Columns>
							<Root>
							</Root>
							<SelectionModel>
								<ext:DefaultSelectionModel ID="DefaultSelectionModel1" runat="server">
									<Listeners>
										<SelectionChange Fn="showCurrPriOperators" />
									</Listeners>
								</ext:DefaultSelectionModel>
							</SelectionModel>
							<Listeners>
								<BeforeLoad Fn="priNodeLoad" />
							</Listeners>
						</ext:TreeGrid>
					</ext:LayoutColumn>
					<ext:LayoutColumn ColumnWidth="0.40">
						<ext:Panel ID="Panel3" runat="server" Border="false" Width="350" StyleSpec="padding:0px;">
							<Items>
								<ext:RowLayout ID="RowLayout1" runat="server" Split="true">
									<Rows>
										<ext:LayoutRow RowHeight="0.5">
											<ext:GridPanel ID="GridPanelOperators" runat="server" Title="<%$ Resources:StringDef, UserOrGroup %>" AutoExpandColumn="Name" 
											Sortable="false" StoreID="StoreOperator" Border="false" StyleSpec="border-left:1px solid #8DB2E3;border-bottom:1px solid #8DB2E3;padding:0px;">
												<TopBar>
													<ext:Toolbar ID="ToolbarSecurityTop" runat="server">
														<Items>
															<ext:Button ID="TbarButtonAddOperator" runat="server" Text="<%$ Resources:StringDef, Add %>"
																Icon="Add" Disabled="true">
																<Listeners>
																	<Click Fn="showAddOperatorWin" />
																</Listeners>
															</ext:Button>
															<ext:Button ID="TbarButtonRemoveOperator" runat="server" Text="<%$ Resources:StringDef, Remove %>"
																Icon="Delete" Disabled="true">
																<Listeners>
																	<Click Fn="removeOperator" />
																</Listeners>
															</ext:Button>
														</Items>
													</ext:Toolbar>
												</TopBar>
												<ColumnModel>
													<Columns>
														<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Sortable="false" >
														</ext:Column>
														<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" Sortable="false" >
														</ext:Column>
														<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Type" Sortable="false" Width="130">
														</ext:Column>
													</Columns>
												</ColumnModel>
												<SelectionModel>
													<ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
														<Listeners>
															<SelectionChange Fn="operatorSelChanged" />
														</Listeners>
													</ext:RowSelectionModel>
												</SelectionModel>
											</ext:GridPanel>
										</ext:LayoutRow>
										<ext:LayoutRow RowHeight="0.5">
											<ext:Panel ID="PanelPrivilege" runat="server" Title="<%$ Resources:StringDef, Privilege %>" Padding="5" Border="false" StyleSpec="border-left:1px solid #8DB2E3; border-top:1px solid #8DB2E3;">
												<TopBar>
													<ext:Toolbar ID="ToolbarPrivilegeTop" runat="server">
														<Items>
															<ext:Button ID="TbarButtonSave" runat="server" Text="<%$ Resources:StringDef, Save %>" Icon="Disk" Disabled="true">
																<Listeners>
																	<Click Fn="savePrivilege" />
																</Listeners>
															</ext:Button>
														</Items>
													</ext:Toolbar>
												</TopBar>
												<Items>
													<ext:CheckboxGroup ID="CbgPrivilege" runat="server" Vertical="true" AutoScroll="true" ColumnsNumber="1" Disabled="true" >
													</ext:CheckboxGroup>
												</Items>
											</ext:Panel>
										</ext:LayoutRow>
									</Rows>
								</ext:RowLayout>
							</Items>
						</ext:Panel>
					</ext:LayoutColumn>
				</Columns>
			</ext:ColumnLayout>
		</Items>
	</ext:Viewport>
	<ext:Window ID="WindowAddOperator" runat="server" Resizable="false" Collapsible="true"
		Width="400" AutoHeight="true" Title="<%$ Resources:StringDef, AddUserOrGroup %>" CloseAction="Hide"
		Hidden="true" AnimateTarget="#{TbarButtonAddOperator}" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelAddGroup" runat="server" ButtonAlign="Right" Padding="10" 
				Border="false" LabelAlign="Right">
				<Items>
					<ext:ComboBox ID="ComboUserAndGroup" runat="server" StoreID="StoreUserAndGroup" Editable="true"
						DisplayField="Name" ValueField="Id" TypeAhead="true" Mode="Local" EmptyText="<%$ Resources:StringDef, ChooseUserOrGroup %>"
						TypeAheadDelay="500" TriggerAction="All" SelectOnFocus="true" ForceSelection="true" ItemSelector="div.list-item" AnchorHorizontal="90%">
						<Template ID="Template1" runat="server">
							<Html>
							<tpl for=".">
									<div class="list-item">
										<h3>{Name}</h3>
										{Comment}[{Type}]
									</div>
								</tpl>
							</Html>
						</Template>
					</ext:ComboBox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonAddOperator" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="addOperator" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="ButtonAddCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowAddOperator}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
</asp:Content>
