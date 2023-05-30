CREATE TABLE IF NOT EXISTS `cabinet` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `GameId` INT(11) NOT NULL DEFAULT '0',
  `Name` VARCHAR(255) NOT NULL DEFAULT '',
  `Comment` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `GameId` (`GameId`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `machine` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `GameId` INT(11) DEFAULT NULL,
  `Name` VARCHAR(255) NOT NULL DEFAULT '',
  `Comment` VARCHAR(255) NOT NULL DEFAULT '',
  `IpAddress` VARCHAR(32) NOT NULL DEFAULT '',
  `IpAddressInner` VARCHAR(32) NOT NULL DEFAULT '',
  `MacAddress` VARCHAR(32) NOT NULL DEFAULT '',
  `Type` INT(11) NOT NULL DEFAULT 0,
  `OSType` INT(11) NOT NULL DEFAULT 0,
  `DTCfgState` INT(11) NOT NULL DEFAULT 0,
  `CabinetId` INT(11) DEFAULT NULL,
  `MasterIpAddress` varchar(32) NOT NULL DEFAULT '',
  `MasterPort` int(11) NOT NULL DEFAULT '9999',
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`CabinetId`) REFERENCES `cabinet` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `gameproc` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `GameId` INT(11) DEFAULT NULL,
  `Name` VARCHAR(255) NOT NULL DEFAULT '',
  `Comment` VARCHAR(255) DEFAULT NULL,
  `GameAppPath` VARCHAR(255) NOT NULL DEFAULT '',
  `MachineId` INT(11) DEFAULT NULL,
  `Version` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`MachineId`) REFERENCES `machine` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `gameregion` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `GameId` INT(11) DEFAULT NULL,
  `Name` VARCHAR(255) NOT NULL DEFAULT '',
  `Comment` VARCHAR(255) NOT NULL DEFAULT '',
  `PlatformId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `gamegroup` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `GameId` INT(11) DEFAULT NULL,
  `Name` VARCHAR(255) NOT NULL DEFAULT '',
  `Comment` VARCHAR(255) NOT NULL DEFAULT '',
  `Mark` INT(11) NOT NULL DEFAULT 0,
  `Flag` int(11) NOT NULL DEFAULT '0',
  `Index` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `proc_in_gamegroup` (
  `ProcId` int(11) NOT NULL DEFAULT '0',
  `GameGroupId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ProcId`,`GameGroupId`),
  FOREIGN KEY (`ProcId`) REFERENCES `gameproc` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`GameGroupId`) REFERENCES `gamegroup` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `gamegroup_in_region` (
  `GameGroupId` int(11) NOT NULL DEFAULT '0',
  `RegionId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`GameGroupId`,`RegionId`),
  FOREIGN KEY (`GameGroupId`) REFERENCES `gamegroup` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`RegionId`) REFERENCES `gameregion` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `eventlog` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Source` INT(11) NOT NULL DEFAULT '0',
  `EventID` INT(11) NOT NULL DEFAULT '0',
  `Level` INT(11) NOT NULL DEFAULT '0',
  `RefID` INT(11) NOT NULL DEFAULT '0',
  `Msg1` LONGTEXT CHARACTER SET utf8,
  `Msg2` LONGTEXT CHARACTER SET utf8,
  `Msg3` LONGTEXT CHARACTER SET utf8,
  `Time` DATETIME DEFAULT NULL,
  `Oper` VARCHAR(255) CHARACTER SET utf8 DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `ftpagent` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Address` varchar(32) NOT NULL DEFAULT '',
  `Comment` varchar(255) NOT NULL DEFAULT '',
  `Port` int(11) NOT NULL DEFAULT '0',
  `UserName` varchar(255) NOT NULL DEFAULT '',
  `Password` varchar(255) NOT NULL DEFAULT '',
  `RemotePath` varchar(255) NOT NULL DEFAULT '',
  `EncodeName` varchar(32) NOT NULL DEFAULT 'utf-8',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `gmop` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Operator` VARCHAR(255) CHARACTER SET gbk COLLATE gbk_bin NOT NULL DEFAULT '',
  `OpType` INT(11) NOT NULL DEFAULT 0,
  `OpInfo` TEXT,
  `AccountName` VARBINARY(255) NOT NULL DEFAULT '',
  `RoleName` VARBINARY(255) NOT NULL DEFAULT '',
  `SvrId` INT(11) DEFAULT NULL,
  `Reason` TEXT CHARACTER SET utf8,
  `Interval` INT(11) DEFAULT -1,
  `Detail` TEXT CHARACTER SET utf8,
  `OperationTime` DATETIME,
  PRIMARY KEY (`Id`),
  KEY `OperatorIndex` (`Operator`),
  KEY `AccountNameIndex` (`AccountName`),
  KEY `RoleNameIndex` (`RoleName`),
  KEY `OperationTimeIndex` (`OperationTime`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `oplog` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Operator` VARCHAR(255) CHARACTER SET utf8,
  `OpType` INT(11) NOT NULL DEFAULT 0,
  `OpInfo` TEXT,
  `RelId` INT(11) DEFAULT NULL,
  `SvrName` TEXT CHARACTER SET utf8,
  `OperationTime` DATETIME,
  PRIMARY KEY (`Id`),
  KEY `OperatorIndex` (`Operator`),
  KEY `OperationTimeIndex` (`OperationTime`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `player_count` (
  `ProcId` INT(11) NOT NULL DEFAULT 0,
  `RecordTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MaxCount` INT(6) NOT NULL DEFAULT '0',
  `MinCount` INT(6) NOT NULL DEFAULT '0',
  `AvgCount` INT(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ProcId`,`RecordTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `schetask` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Classify` INT(11) NOT NULL DEFAULT 0,
  `TaskData` BLOB NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `strategy` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Desc` TEXT,
  `Event` INT(11) NOT NULL DEFAULT '0',
  `AutomationData` BLOB NOT NULL,
  `Enable` INT(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `svrcfg` (
  `ProcId` int(11) NOT NULL,
  `BSWorldNum` int(11) DEFAULT '-1',
  `NetMaxCon` int(11) DEFAULT '2000',
  `NetPort` int(11) DEFAULT '18008',
  `NetThreadNum` int(11) DEFAULT '2',
  `NetSendBuff` int(11) DEFAULT '32768',
  `NetRecvBuff` int(11) DEFAULT '32768',
  `NetMaxQueue` int(11) DEFAULT '3000',
  `DbMachineId` int(11) DEFAULT '0',
  `DbHostName` text,
  `DbInnerIP` text,
  `DbUser` text,
  `DbPwd` text,
  `DbDBName` text,
  `DbPort` int(11) DEFAULT '3306',
  `DbConNum` int(11) DEFAULT '0',
  `LogDbMachineId` int(11) DEFAULT '0',
  `LogDbHostName` text,
  `LogDbInnerIP` text,
  `LogDbUser` text,
  `LogDbPwd` text,
  `LogDbDBName` text,
  `LogDbPort` int(11) DEFAULT '3306',
  `LogDbConNum` int(11) DEFAULT '0',
  `PaymentOn` int(11) DEFAULT '1',
  `PaymentHostName` text,
  `PaymentPort` int(11) DEFAULT '1',
  `PaymentRechargeHost` text,
  `PaymentRechargePort` int(11) DEFAULT '1',
  `PaymentGatewayAcc` text,
  `PaymentGatewayPwd` text,
  `PaymentGateId` int(11) DEFAULT '1',
  `PaymentGameId` int(11) DEFAULT '19',
  `LangCharSet` text,
  `UseCustomLogDb` int(11) NOT NULL DEFAULT '0',
  `NoEnter` int(11) NOT NULL DEFAULT '0',
  `PaymentJoinOver` int(11) NOT NULL DEFAULT '600',
  `PaymentJoinKey` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`ProcId`),
  FOREIGN KEY (`ProcId`) REFERENCES `gameproc` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE IF NOT EXISTS `platform` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL DEFAULT '',
  `ShortName` varchar(255) NOT NULL DEFAULT '',
  `DomainName` varchar(1024) DEFAULT '',
  `ErrUrl` text,
  `MaintainUrl` text,
  `ChargeUrl` text,
  `HomepageUrl` text,
  `KefuUrl` text,
  `BBSUrl` text,
  `FCMUrl` text,
  `FavUrl` text,
  `UpdateVer` varchar(255) NOT NULL DEFAULT '',
  `SelfUpdateVer` varchar(255) NOT NULL DEFAULT '',
  `PriorityVer` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DELIMITER //

DROP PROCEDURE IF EXISTS AddGroup;
CREATE PROCEDURE AddGroup(
  IN paramName VARCHAR(64),
  IN paramParentId INT(11),
  IN paramObjComment VARCHAR(64),
  IN paramComment VARCHAR(64),
  IN paramFlag INT(11)
)
BEGIN
  INSERT INTO `sec_object`(`name`, `parent_id`, `comment`) VALUES(paramName, paramParentId, paramObjComment);
  INSERT INTO `group`(`id`, `name`, `comment`, `flag` ) VALUES(LAST_INSERT_ID(), paramName, paramComment, paramFlag);
  SELECT * FROM `group` WHERE `id`=LAST_INSERT_ID();
END;


DROP PROCEDURE IF EXISTS AddSecObject;
CREATE PROCEDURE AddSecObject(
  IN paramName VARCHAR(64),
  IN paramParentId INT(11),
  IN paramComment VARCHAR(64)
)
BEGIN
  INSERT INTO `sec_object`(`name`, `parent_id`, `comment`) VALUES(paramName, paramParentId, paramComment);
  SELECT * FROM `sec_object` WHERE `id`=LAST_INSERT_ID();
END;


DROP PROCEDURE IF EXISTS AddUser;
CREATE PROCEDURE AddUser(
  IN paramName VARCHAR(32),
  IN paramParentId INT(11),
  IN paramObjComment VARCHAR(64),
  IN paramRealName VARCHAR(32),
  IN paramComment VARCHAR(64),
  IN paramPassword VARCHAR(64),
  IN paramNoLogin INT(4),
  IN paramRestrictAddress VARCHAR(255),
  IN paramAuthType INT(4)
)
BEGIN
  INSERT INTO `sec_object`(`name`, `parent_id`, `comment`) VALUES(paramName, paramParentId, paramObjComment);
  INSERT INTO `user`(`id`, `name`, `real_name`, `comment`, `password`, `no_login`, `restrict_address`, `auth_type`) VALUES(LAST_INSERT_ID(), paramName, paramRealName, paramComment, paramPassword, paramNoLogin, paramRestrictAddress, paramAuthType);
  SELECT * FROM `user` WHERE `id`=LAST_INSERT_ID();
END;


DROP PROCEDURE IF EXISTS AddUserToGroup;
CREATE PROCEDURE AddUserToGroup(
  IN paramUserId INT(4),
  IN paramGroupId INT(4)
)
BEGIN
  INSERT INTO `user_in_group` VALUES(paramUserId, paramGroupId);
END;


DROP PROCEDURE IF EXISTS DeleteGroup;
CREATE PROCEDURE DeleteGroup(
  IN paramId INT(6)
)
BEGIN
  CALL DeleteSecObject( paramId );
END;


DROP PROCEDURE IF EXISTS DeleteSecObject;
CREATE PROCEDURE DeleteSecObject(
  IN paramId INT(11)
)
BEGIN
  DELETE FROM `sec_object` WHERE `id`=paramId;
END;


DROP PROCEDURE IF EXISTS DeleteUser;
CREATE PROCEDURE DeleteUser(
  IN paramId INT(6)
)
BEGIN
  CALL DeleteSecObject( paramId );
END;


DROP PROCEDURE IF EXISTS GetPrivilege;
CREATE PROCEDURE GetPrivilege(
  IN paramOperatorId INT(11),
  IN paramTargetId INT(11)
)
BEGIN
  IF paramOperatorId = -1 THEN
    SELECT * FROM `privilege_control` WHERE `target_id`=paramTargetId;
  ELSE
    SELECT * FROM `privilege_control` WHERE `target_id`=paramTargetId AND `operator_id`=paramOperatorId;
  END IF;
END;


DROP PROCEDURE IF EXISTS InheritPrivilege;
CREATE PROCEDURE InheritPrivilege(
  IN paramObjId INT(11),
  IN paramObjParentId INT(11)
)
BEGIN
  REPLACE INTO `privilege_control` ( SELECT `operator_id`, paramObjId, 1, 1 FROM `privilege_control` WHERE `target_id`=paramObjParentId );
END;


DROP PROCEDURE IF EXISTS LoadGroup;
CREATE PROCEDURE LoadGroup()
BEGIN
  SELECT * FROM `group`;
END;

DROP PROCEDURE IF EXISTS LoadPrivilegeControl;
CREATE PROCEDURE LoadPrivilegeControl()
BEGIN
  SELECT * FROM privilege_control;
END;

DROP PROCEDURE IF EXISTS LoadSecObject;
CREATE PROCEDURE LoadSecObject()
BEGIN
  SELECT * FROM `sec_object`;
END;


DROP PROCEDURE IF EXISTS LoadUser;
CREATE PROCEDURE LoadUser()
BEGIN
  SELECT * FROM `user`;
END;

DROP PROCEDURE IF EXISTS LoadUserGroupControl;
CREATE PROCEDURE LoadUserGroupControl()
BEGIN
  SELECT * FROM user_in_group;
END;


DROP PROCEDURE IF EXISTS ModifyGroup;
CREATE PROCEDURE ModifyGroup(
  IN paramId INT(4),
  IN paramComment VARCHAR(64),
  IN paramFlag INT(11)
)
BEGIN
  UPDATE `group` SET `comment`=paramComment, `flag`=paramFlag WHERE `id`=paramId;
END;


DROP PROCEDURE IF EXISTS ModifyUser;
CREATE PROCEDURE ModifyUser(
  IN paramId INT(4),
  IN paramRealName VARCHAR(32),
  IN paramComment VARCHAR(64),
  IN paramPassword VARCHAR(64),
  IN paramNoLogin INT(4),
  IN paramRestrictAddress VARCHAR(255),
  IN paramAuthType INT(4)
)
BEGIN
  UPDATE `user` SET `real_name`=paramRealName, `comment`=paramComment, `password`=paramPassword, `no_login`=paramNoLogin,
    `restrict_address`=paramRestrictAddress, `auth_type`=paramAuthType WHERE `id`=paramId;
END;


DROP PROCEDURE IF EXISTS RemoveInheritPrivilege;
CREATE PROCEDURE RemoveInheritPrivilege(
  IN paramOperatorId INT(11),
  IN paramTargetParentId INT(11)
)
BEGIN
  DELETE FROM `privilege_control` WHERE `operator_id`=paramOperatorId AND `target_id` IN ( SELECT `id` FROM `sec_object` WHERE `parent_id`=paramTargetParentId );
END;


DROP PROCEDURE IF EXISTS RemovePrivilege;
CREATE PROCEDURE RemovePrivilege(
  IN paramOperatorId INT(11),
  IN paramTargetId INT(11)
)
BEGIN
  DELETE FROM `privilege_control` WHERE `operator_id`=paramOperatorId AND `target_id`=paramTargetId;
END;


DROP PROCEDURE IF EXISTS RemoveUserFromGroup;
CREATE PROCEDURE RemoveUserFromGroup(
  IN paramUserId INT(4),
  IN paramGroupId INT(4)
)
BEGIN
  DELETE FROM `user_in_group` WHERE `user_id`=paramUserId AND `group_id`=paramGroupId;
END;


DROP PROCEDURE IF EXISTS SetInheritPrivilege;
CREATE PROCEDURE SetInheritPrivilege(
  IN paramOperatorId INT(11),
  IN paramTargetParentId INT(11)
)
BEGIN
  REPLACE INTO `privilege_control` ( SELECT paramOperatorId, `id`, 1, 1 FROM `sec_object` WHERE `parent_id`=paramTargetParentId );
END;


DROP PROCEDURE IF EXISTS SetPrivilege;
CREATE PROCEDURE SetPrivilege(
  IN paramOperatorId INT(11),
  IN paramTargetId INT(11),
  IN paramPrivilege INT(11),
  IN paramInherit INT(11)
)
BEGIN
  REPLACE INTO `privilege_control` VALUES(paramOperatorId, paramTargetId, paramPrivilege, paramInherit);
END;

CREATE TABLE IF NOT EXISTS `sec_object` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `NAME` varchar(64) NOT NULL default '',
  `COMMENT` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `real_name` varchar(32) default NULL,
  `comment` varchar(64) default NULL,
  `password` varchar(64) NOT NULL,
  `no_login` int(6) NOT NULL default '0',
  `restrict_address` varchar(255) NOT NULL default '%',
  `auth_type` int(11) NOT NULL default '0',
  `key_card` blob,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `NameIndex` (`name`),
  FOREIGN KEY  (`id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE IF NOT EXISTS `group` (
  `id` int(6) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `comment` varchar(64) NOT NULL,
  `flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  FOREIGN KEY  (`id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE IF NOT EXISTS `privilege_control` (
  `operator_id` int(11) NOT NULL default '0',
  `target_id` int(11) NOT NULL default '0',
  `privilege` int(11) NOT NULL default '0',
  `inherit` int(11) NOT NULL default '1',
  PRIMARY KEY  (`operator_id`,`target_id`),
  FOREIGN KEY  (`operator_id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY  (`target_id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE IF NOT EXISTS `user_in_group` (
  `user_id` int(6) NOT NULL default '0',
  `group_id` int(6) NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`group_id`),
  FOREIGN KEY  (`user_id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY  (`group_id`) REFERENCES `sec_object` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


DROP TRIGGER IF EXISTS UpdateSecObject;
CREATE TRIGGER UpdateSecObject AFTER INSERT ON `sec_object`
FOR EACH ROW
BEGIN
  CALL InheritPrivilege( NEW.id, NEW.parent_id );
END;


DROP PROCEDURE IF EXISTS QueryEvent;
CREATE PROCEDURE QueryEvent(
  IN paramSource INT(11),
  IN paramRefID INT(11),
  IN paramTimeStart DateTime,
  IN paramTimeEnd DateTime,
  IN paramOper Varchar(255),
  IN paramMsg1 TEXT,
  IN paramMsg2 TEXT,
  IN paramMsg3 TEXT,
  IN paramSortField Varchar(64),
  IN paramSortType INT(11),
  IN paramLimit INT(11),
  IN paramOffset INT(11),
  OUT paramTotalCount INT(11)
)
BEGIN
  DECLARE _whereStatement TEXT DEFAULT "";
  DECLARE _limitStatement VARBINARY(50) DEFAULT "";
  DECLARE _orderStatement VARBINARY(50) DEFAULT "";
  DECLARE _totalCount INT(11) DEFAULT 0;

  IF( paramSource IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Source` = ", paramSource );
  END IF;

  IF( paramRefID IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `RefID` = ", paramRefID );
  END IF;

  IF( paramTimeStart IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Time` >= '", paramTimeStart, "'" );
  END IF;

  IF( paramTimeEnd IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Time` <= '", paramTimeEnd, "'" );
  END IF;

  IF( paramOper IS NOT NULL && LENGTH( paramOper ) > 0 ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Oper` LIKE '%", paramOper, "%'" );
  END IF;

  IF( paramMsg1 IS NOT NULL && LENGTH( paramMsg1 ) > 0 ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Msg1` LIKE '%", paramMsg1, "%'" );
  END IF;

  IF( paramMsg2 IS NOT NULL && LENGTH( paramMsg2 ) > 0 ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Msg2` LIKE '%", paramMsg2, "%'" );
  END IF;

  IF( paramMsg3 IS NOT NULL && LENGTH( paramMsg3 ) > 0 ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `Msg3` LIKE '%", paramMsg3, "%'" );
  END IF;

  IF( LENGTH( _whereStatement ) > 5 ) THEN
    SET _whereStatement = CONCAT( " WHERE", SUBSTRING( _whereStatement, 5 ) );
  END IF;

  IF( paramLimit IS NOT NULL ) THEN
    IF( paramOffset IS NOT NULL ) THEN
      SET _limitStatement = CONCAT( " LIMIT ", paramOffset, ",", paramLimit );
    ELSE
      SET _limitStatement = CONCAT( " LIMIT ", paramLimit );
    END IF;
  END IF;

  IF( paramSortField IS NOT NULL ) THEN
    SET _orderStatement = CONCAT( " ORDER BY ", paramSortField );
    IF( paramSortType = 0 ) THEN
      SET _orderStatement = CONCAT( _orderStatement, " ASC " );
    ELSE
      SET _orderStatement = CONCAT( _orderStatement, " DESC " );
    END IF;
  END IF;

  SET @statement = CONCAT( "SELECT * FROM `eventlog` ", _whereStatement, _orderStatement, _limitStatement );
  PREPARE stmt FROM @statement;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  SET @statement = CONCAT( "SELECT COUNT(*) INTO @totalCount FROM `eventlog` ", _whereStatement );
  PREPARE stmt FROM @statement;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  SET paramTotalCount = @totalCount;
END;


DROP PROCEDURE IF EXISTS QueryEventLog;
CREATE PROCEDURE QueryEventLog(
  IN paramSource INT(6),
  IN paramRefID INT(6),
  IN paramEvents TEXT,
  IN paramMsg1 TEXT,
  IN paramMsg2 TEXT,
  IN paramMsg3 TEXT,
  IN paramStartTime DATETIME,
  IN paramEndTime DATETIME,
  IN paramSortField VARCHAR(64),
  IN paramSortType INT(11),
  IN paramLimit INT(11),
  IN paramOffset INT(11),
  OUT paramTotalCount INT(11)
)
BEGIN
  DECLARE _whereStatement TEXT DEFAULT "";
  DECLARE _limitStatement VARCHAR(50) DEFAULT "";
  DECLARE _orderStatement VARCHAR(128) DEFAULT "";
  DECLARE _totalCount INT(11) DEFAULT 0;

  IF( paramSource IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `UserId` = ", paramSource );
  END IF;

  IF( paramStartTime IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `RecordTime` >= '", paramStartTime, "'" );
  END IF;

  IF( paramEndTime IS NOT NULL ) THEN
    SET _whereStatement = CONCAT( _whereStatement, " AND `RecordTime` <= '", paramEndTime, "'" );
  END IF;

  IF( LENGTH( _whereStatement ) > 5 ) THEN
    SET _whereStatement = CONCAT( " WHERE", SUBSTRING( _whereStatement, 5 ) );
  END IF;

  IF( paramLimit IS NOT NULL ) THEN
    IF( paramOffset IS NOT NULL ) THEN
      SET _limitStatement = CONCAT( " LIMIT ", paramOffset, ",", paramLimit );
    ELSE
      SET _limitStatement = CONCAT( " LIMIT ", paramLimit );
    END IF;
  END IF;

  IF( paramSortField IS NOT NULL ) THEN
    SET _orderStatement = CONCAT( " ORDER BY ", paramSortField );
    IF( paramSortType = 0 ) THEN
      SET _orderStatement = CONCAT( _orderStatement, " ASC " );
    ELSE
      SET _orderStatement = CONCAT( _orderStatement, " DESC " );
    END IF;
  END IF;

  SET @statement = CONCAT( "SELECT COUNT(*) INTO @totalCount FROM `user_msg`", _whereStatement );
  PREPARE stmt FROM @statement;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  SET paramTotalCount = @totalCount;

  SET @statement = CONCAT( "SELECT * FROM `user_msg`", _whereStatement, _orderStatement, _limitStatement );
  PREPARE stmt FROM @statement;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

END;

//

DELIMITER ;


INSERT INTO `sec_object` VALUES( 1, 0, 'system', '' );
INSERT INTO `sec_object` VALUES( 2, 1, 'security', '' );
INSERT INTO `sec_object` VALUES( 3, 2, 'groups', '' );
INSERT INTO `sec_object` VALUES( 4, 2, 'users', '' );

INSERT INTO `sec_object` VALUES( 5, 3, 'Administrators', '' );
INSERT INTO `group` VALUES( 5, 'Administrators', '', 0 );
INSERT INTO `privilege_control` VALUES( 5, 1, 2147483646, 0 );
INSERT INTO `privilege_control` VALUES( 5, 2, 1, 1 );
INSERT INTO `privilege_control` VALUES( 5, 3, 1, 1 );
INSERT INTO `privilege_control` VALUES( 5, 4, 1, 1 );
INSERT INTO `privilege_control` VALUES( 5, 5, 1, 1 );

INSERT INTO `sec_object` VALUES( 6, 4, 'mqmaster', '' );
INSERT INTO `user` VALUES( 6, 'mqmaster', 'MQ Master', '', '0e9354c70755e0455ad92c6d96dded0d', 0, '%', 0, NULL );
INSERT INTO `user_in_group` VALUES( 6, 5 );

INSERT INTO `sec_object` VALUES( 7, 4, 'lkadmin', '' );
INSERT INTO `user` VALUES( 7, 'lkadmin', 'LineKong Admin', '', '47dc0b26a34297733090991bab6e91b1', 0, '%', 0, NULL );
INSERT INTO `user_in_group` VALUES( 7, 5 );


