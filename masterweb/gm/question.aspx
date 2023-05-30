<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_question, App_Web_question.aspx.b931aa99" validaterequest="false" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.x-form-group .x-form-group-header-text {
			background-color: #dfe8f6;
		}
		
		.x-label-text {
			font-weight: bold;
		}
		
		.question {
			border: solid 1px #CCC !important;
			color: #666;
		}
		
		.notereply {
			font-weight: bold;
			color:blue !important;
			width: 100%;
		}
	</style>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';

		var msgReplyCanNotBeNull		= '<%= Resources.StringDef.MsgReplyCanNotBeNull %>';
		var msgReplySuccess				= '<%= Resources.StringDef.MsgReplySuccess %>';
		var msgDeleteSuccess			= '<%= Resources.StringDef.MsgDeleteSuccess %>';
		var msgQuestionSummaryFormat	= '<%= Resources.StringDef.MsgQuestionSummaryFormat %>';
		var msgAssignedQuestion			= '<%= Resources.StringDef.AssignedQuestion %>';
		var msgExpiryDateFormat			= '<%= Resources.StringDef.MsgExpiryDateFormat %>';

		var msgQuestionTypeBug			= '<%= Resources.StringDef.QuestionTypeBug %>';
		var msgQuestionTypeComplaint	= '<%= Resources.StringDef.QuestionTypeComplaint %>';
		var msgQuestionTypeAdvice		= '<%= Resources.StringDef.QuestionTypeAdvice %>';
		var msgQuestionTypeOther		= '<%= Resources.StringDef.QuestionTypeOther %>';

		var msgQuestionStateReplied		= '<%= Resources.StringDef.QuestionStateReplied %>'
		var msgQuestionStateDeleted		= '<%= Resources.StringDef.QuestionStateDeleted %>';
		var msgQuestionStateUnreply		= '<%= Resources.StringDef.QuestionStateUnreply %>'; ;

		var msgQuestionReplyConfirm		= '<%= Resources.StringDef.MsgQuestionReplyConfirm %>'; ;
		var msgQuestionDeleteConfirm	= '<%= Resources.StringDef.MsgQuestionDeleteConfirm %>'; ;
		var msgQuestionExpireNote		= '<%= Resources.StringDef.QuestionExpireNote %>'; ;
		var msgExpired					= '<%= Resources.StringDef.Expired %>';
		var msgReply					= '<%= Resources.StringDef.MsgAutoReply %>'
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var m_expireTime;					//问题过期时间
			var m_expireRemind;
		
			var renderDateTime = function( value, metadata, record, rowIndex, colIndex, store ) {
				return value.replace( / /g, "<br />" );
			};
			
			var renderContent = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", htmlencode( value ) );
			};
			
			var renderType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgQuestionTypeBug;
					case 1:
						return msgQuestionTypeComplaint;
					case 2:
						return msgQuestionTypeAdvice;
					case 3:
					default:
						return msgQuestionTypeOther;
				}
			};
			
			var renderState = function( value, metadata, record, rowIndex, colIndex, store ) {
				var feedback = record.data.IsFeedback;
				var hasReply = ( record.data.Reply.length > 0 );
			
				if( feedback ) {
					if( hasReply )
						return msgQuestionStateReplied;
					else
						return msgQuestionStateDeleted;
				} else {
					return msgQuestionStateUnreply;
				}
			};
			
			var gridQuestionRowSelect = function( selectionModel, rowIndex, record ) {
				#{StoreRelQuestion}.removeAll( true );
				#{FormDetail}.reset( );
				#{FormDetail}.getForm( ).loadRecord( record );
				
				#{FieldQuestionType}.setValue( renderType( record.data.Type ) );
				
				//#{FieldReply}.focus( );
			};
			
			var gridQuestionSelectionChange = function( el ) {
				#{FormDetail}.setVisible( el.getCount( ) > 0 );
				#{CompositeField1}.setVisible( true );
				
				if( el.getCount( ) < 1 )
					#{WindowRelQuestion}.hide( );
			};
			
			var btnReplyClick = function( ) {
				var record = #{GridPanelQuestion}.getSelectionModel( ).getSelected( );
				if( !record )
					return;
				
				var reply = #{FieldReply}.getValue( );
				if( reply.length == 0 ) {
					showErrMsg( msgTitle, msgReplyCanNotBeNull );
					return;
				}
				
				var ggId		= record.data.GameGroupId;
				var roleName	= record.data.RoleName;
				var qid			= record.data.Id;
				
				var result = showConfirmMsg( msgTitle, msgQuestionReplyConfirm, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.ReplyQuestion( ggId, roleName, qid, reply, {
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgReplySuccess );
									#{StoreQuestion}.remove( record );
									#{StoreQuestion}.commitChanges( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var btnDeleteClick = function( ) {
				var record = #{GridPanelQuestion}.getSelectionModel( ).getSelected( );
				if( !record )
					return;
				
				var ggId		= record.data.GameGroupId;
				var qid			= record.data.Id;
				var roleName	= record.data.RoleName;
				
				var result = showConfirmMsg( msgTitle, msgQuestionDeleteConfirm, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteQuestion( ggId, qid, {
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgDeleteSuccess );
									autoReplyQuestion( ggId, qid, roleName, msgReply );
									#{StoreQuestion}.remove( record );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				});
			};
			
			var autoReplyQuestion = function( ggId, qid, roleName, msgReply ) {
				
				Ext.net.DirectMethods.ReplyQuestion( ggId, roleName, qid, msgReply,{
					eventMask:	{
						showMask : true,
						minDelay : 200,
						msg		 : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{StoreQuestion}.commitChanges( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var btnRelQuestionClick = function( ) {
				#{StoreRelQuestion}.load( );
				#{WindowRelQuestion}.show( );
			};
			
			var getRelQuestionQueryParams = function( store, options ) {
				var record = #{GridPanelQuestion}.getSelectionModel( ).getSelected( );
				if( !record )
					return;
				
				var ggId		= record.data.GameGroupId;
				var qid			= record.data.Id;
				var roleName	= record.data.RoleName;
				
				options.params.GameGroupId	= ggId;
				options.params.QuestionId	= qid;
				options.params.RoleName		= roleName;
			};
			
			var refreshTotalCount = function( ) {
				Ext.net.DirectMethods.RefreshTotalCount( {
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{FieldSummary}.setValue( String.format( msgQuestionSummaryFormat, 
								result.Result.TotalCount,
								result.Result.TotalUnreplyCount,
								result.Result.TotalReplyedCount,
								result.Result.TotalDeletedCount,
								result.Result.TimeStamp ) );
						}
					}
				} );
			};
			
			var btnUnlockClick = function( ) {
				Ext.net.DirectMethods.UnlockQuestion( {
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							m_expireTime = new Date( );
							
							#{GridPanelQuestion}.setTitle( msgAssignedQuestion + ' - ' + String.format( "<span style='color:red;font-weight:bold;'>{0}</span>", msgExpired ) );
						} else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnAssignClick = function( ) {
				refreshQuestion( );
				refreshTotalCount( );
			};
			
			var textFieldReplyKeydown = function( el, e ) {

				if( m_expireRemind ) {
					var currTime = new Date( );
					if( currTime > m_expireTime ) {
						showErrMsg( msgTitle, msgQuestionExpireNote );
						m_expireRemind = 0;
						return;
					}
				}
			
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					
					e.stopEvent( );
				}
			};
			
			var refreshQuestion = function ( ) {
				#{StoreQuestion}.load( { 
					callback : function( ) {
						m_expireTime	= new Date( ).add( Date.MINUTE, 20 );
						m_expireRemind	= 1;
						#{GridPanelQuestion}.setTitle( msgAssignedQuestion + ' - ' + String.format( msgExpiryDateFormat, getDateTimeString( m_expireTime ) ) );
					}
				} );
			};
			
			var initData = function( ) {
				refreshQuestion( );
				refreshTotalCount( );
				
				#{FormDetail}.setVisible( false );
				#{GridPanelQuestion}.setTitle( msgAssignedQuestion + ' - ' + String.format( msgExpiryDateFormat, getDateTimeString( new Date( ).add( Date.MINUTE, 5 ) ) ) );
			};
			
		</script>
	</ext:XScript>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreQuestion" runat="server" OnRefreshData="StoreQuestionRefresh" AutoLoad="false" WarningOnDirty="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelQuestion}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="GameGroupName" Mapping="GameGroupName" Type="String" />
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="CommitTime" Mapping="CommitTime" Type="String" />
					<ext:RecordField Name="Question" Mapping="Question" Type="String" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="GameGroupId" Mapping="GameGroupId" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreRelQuestion" runat="server" OnRefreshData="StoreRelQuestionRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridRelQuestion}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getRelQuestionQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="CommitTime" Mapping="CommitTime" Type="String" />
					<ext:RecordField Name="Question" Mapping="Question" Type="String" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="Reply" Mapping="Reply" Type="String" />
					<ext:RecordField Name="Replyer" Mapping="Replyer" Type="String" />
					<ext:RecordField Name="ReplyTime" Mapping="ReplyTime" Type="String" />
					<ext:RecordField Name="IsFeedback" Mapping="IsFeedback" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Direction="DESC" Field="ReplyTime" />
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:GridPanel ID="GridPanelQuestion" runat="Server" Border="true" StoreID="StoreQuestion" Height="290" ColumnLines="true" StripeRows="true"
						AutoExpandColumn="Question" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, AssignedQuestion %>" >
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:DisplayField ID="FieldSummary" runat="Server"></ext:DisplayField>
									<ext:ToolbarFill />
									<ext:Button ID="Button2" runat="server" Icon="LockOpen" Scale="Medium" Text="<%$ Resources:StringDef, UnlockQuestion %>" >
										<Listeners>
											<Click Fn="btnUnlockClick" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="Button1" runat="server" Icon="Accept" Scale="Medium" Text="<%$ Resources:StringDef, Redistribute %>" >
										<Listeners>
											<Click Fn="btnAssignClick" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:StatusBar ID="StatusBar1" runat="Server">
								<Items>
									<ext:DisplayField runat="Server" ID="QuestionUseNote" Text="<%$ Resources:StringDef, QuestionUseNote %>" ></ext:DisplayField>
								</Items>
							</ext:StatusBar>
						</BottomBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="GameGroupName" Width="80">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="100">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CommitTime %>" DataIndex="CommitTime" Width="130">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Type" Width="80">
									<Renderer Fn="renderType" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Question %>" DataIndex="Question" Align="Left">
									<Renderer Fn="renderContent" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server" SingleSelect="true">
								<Listeners>
									<SelectionChange Fn="gridQuestionSelectionChange" />
									<RowSelect Fn="gridQuestionRowSelect" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</North>
				<Center>
					<ext:FormPanel ID="FormDetail" runat="Server" LabelWidth="80" Title="<%$ Resources:StringDef, QuestionDetail %>" Width="400"
						Height="140" Padding="5" ButtonAlign="Center" Border="true" Margins="0px 10px 10px 10px" AnchorHorizontal="100%" LabelAlign="Right" AutoScroll="true" >
						<Items>
							<ext:Container ID="Container1" runat="server" Layout="Column" Height="25">
								<Items>
									<ext:Container ID="Container2" runat="server" Layout="Form">
										<Items>
											<ext:DisplayField ID="FieldGameServer" runat="server" Width="120" FieldLabel="<%$ Resources:StringDef, GameServer %>" DataIndex="GameGroupName" />
										</Items>
									</ext:Container>
									<ext:Container ID="Container3" runat="server" Layout="Form">
										<Items>
											<ext:DisplayField ID="FieldQuestionType" Width="80" runat="server" FieldLabel="<%$ Resources:StringDef, Type %>" />
										</Items>
									</ext:Container>
									<ext:Container ID="Container7" runat="server" Layout="Form">
										<Items>
											<ext:DisplayField ID="DisplayField2" runat="server" FieldLabel="<%$ Resources:StringDef, CommitTime %>" DataIndex="CommitTime" />
										</Items>
									</ext:Container>
								</Items>
							</ext:Container>
							<ext:Container ID="Container5" runat="server" Layout="Column" Height="25">
								<Items>
									<ext:Container ID="Container8" runat="server" Layout="Form">
										<Items>
											<ext:DisplayField ID="FieldAccount" runat="server" Width="120" FieldLabel="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" />
										</Items>
									</ext:Container>
									<ext:Container ID="Container9" runat="server" Layout="Form">
										<Items>
											<ext:DisplayField ID="FieldRoleName" runat="server" FieldLabel="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" />
										</Items>
									</ext:Container>
								</Items>
							</ext:Container>
							<ext:Container ID="Container4" runat="server" Layout="Form">
								<Items>
									<ext:TextArea ID="FieldQuestion" runat="server" FieldLabel="<%$ Resources:StringDef, Question %>"
										DataIndex="Question" Width="350" Height="50" ReadOnly="true" Cls="question" AnchorHorizontal="95%" />
								</Items>
							</ext:Container>
							<ext:Container ID="Container6" runat="server" Layout="Form">
								<Items>
									<ext:TextArea ID="FieldReply" runat="Server" FieldLabel="<%$ Resources:StringDef, Reply %>"
										Width="350" Height="50" AnchorHorizontal="95%" EnableKeyEvents="true" MaxLength="128">
										<Listeners>
											<KeyDown Fn="textFieldReplyKeydown" />
										</Listeners>
									</ext:TextArea>
									<ext:DisplayField ID="FieldNote" runat="Server" Cls="notereply" Text="<%$ Resources:StringDef, QuestionReplyNote %>">
									</ext:DisplayField>
									<ext:CompositeField ID="CompositeField2" runat="Server" />
									<ext:CompositeField ID="CompositeField1" runat="Server" Hidden="false">
										<Items>
											<ext:Button ID="BtnReply" runat="Server" Text="<%$ Resources:StringDef, Reply %>" Width="80">
												<Listeners>
													<Click Fn="btnReplyClick" />
												</Listeners>
											</ext:Button>
											<ext:Button ID="BtnDelete" runat="Server" Text="<%$ Resources:StringDef, Delete %>" Width="80">
												<Listeners>
													<Click Fn="btnDeleteClick" />
												</Listeners>
											</ext:Button>
											<ext:Button ID="BtnRelQuestion" runat="Server" Text="<%$ Resources:StringDef, RelQuestion %>" Width="80">
												<Listeners>
													<Click Fn="btnRelQuestionClick" />
												</Listeners>
											</ext:Button>
										</Items>
									</ext:CompositeField>
								</Items>
							</ext:Container>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowRelQuestion" runat="Server" Width="1124" Height="450" CloseAction="Hide" Resizable="true" Maximizable="true"
		Hidden="true" Modal="false" Title="<%$ Resources:StringDef, RelQuestion %>">
		<Items>
			<ext:BorderLayout ID="BorderLayout3" runat="Server">
				<Center>
					<ext:GridPanel ID="GridRelQuestion" runat="Server" Border="false" StoreID="StoreRelQuestion" StripeRows="true"
						AutoExpandColumn="Reply">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="100" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CommitTime %>" DataIndex="CommitTime" Width="70" Align="Center">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Question %>" DataIndex="Question" Width="250" Align="Left" Sortable="false">
									<Renderer Fn="renderContent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Align="Left" Width="50">
									<Renderer Fn="renderState" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Replyer %>" DataIndex="Replyer"  Align="Center" Width="70">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ReplyTime %>" DataIndex="ReplyTime" Align="Center" Width="70">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Reply %>" DataIndex="Reply" Align="Left" Sortable="false" >
									<Renderer Fn="renderContent" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server" SingleSelect="true">
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

