USE [SAMRTHOct23]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 28-01-2020 20:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split](@String nvarchar(4000), @Delimiter char(1))
RETURNS @Results TABLE (Items nvarchar(4000))
AS
BEGIN
DECLARE @INDEX INT
DECLARE @SLICE nvarchar(4000)
-- HAVE TO SET TO 1 SO IT DOESNT EQUAL Z
--     ERO FIRST TIME IN LOOP
SELECT @INDEX = 1
WHILE @INDEX !=0
BEGIN
-- GET THE INDEX OF THE FIRST OCCURENCE OF THE SPLIT CHARACTER
SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)
-- NOW PUSH EVERYTHING TO THE LEFT OF IT INTO THE SLICE VARIABLE
IF @INDEX !=0
SELECT @SLICE = LEFT(@STRING,@INDEX - 1)
ELSE
SELECT @SLICE = @STRING
-- PUT THE ITEM INTO THE RESULTS SET
INSERT INTO @Results(Items) VALUES(@SLICE)
-- CHOP THE ITEM REMOVED OFF THE MAIN STRING
SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)
-- BREAK OUT IF WE ARE DONE
IF LEN(@STRING) = 0 BREAK
END
RETURN
END


GO
/****** Object:  Table [dbo].[AddPMContainer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddPMContainer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NULL,
	[Quantity] [decimal](36, 3) NULL,
	[DateOfReceival] [datetime] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModidfiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK_AddPMContainer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BatchDepot]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchDepot](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NULL,
	[DepotId] [int] NULL,
	[IsActive] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_BatchDepot] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BatchMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchMaster](
	[BID] [int] IDENTITY(1,1) NOT NULL,
	[BatchName] [varchar](50) NULL,
	[BatchCode] [varchar](50) NULL,
	[BatchDesc] [varchar](1000) NULL,
	[BatchNo] [varchar](max) NULL,
	[ATNo] [varchar](50) NULL,
	[VechicleNo] [varchar](50) NULL,
	[RecievedFrom] [varchar](50) NULL,
	[PID] [int] NULL,
	[MFGDate] [datetime] NULL,
	[EXPDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsDeleted] [bit] NULL,
	[DepotID] [int] NULL,
	[Esl] [datetime] NULL,
	[IsSentto] [bit] NULL,
	[IsBatchStatus] [varchar](50) NULL,
	[StockId] [int] NULL,
	[ContactNo] [varchar](max) NULL,
	[Remarks] [varchar](500) NULL,
	[Cost] [decimal](36, 2) NULL,
	[CostOfParticular] [decimal](18, 2) NULL,
	[Weight] [decimal](36, 18) NULL,
	[WeightofParticular] [decimal](36, 18) NULL,
	[WeightUnit] [varchar](50) NULL,
	[WarehouseNo] [varchar](500) NULL,
	[SampleSentQty] [decimal](36, 18) NULL,
	[WarehouseID] [int] NULL,
	[SectionID] [int] NULL,
	[SectionRows] [int] NULL,
	[SectionCol] [int] NULL,
 CONSTRAINT [PK_BatchMaster] PRIMARY KEY CLUSTERED 
(
	[BID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoryMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category_Code] [varchar](50) NULL,
	[Category_Name] [varchar](50) NULL,
	[Category_TypeId] [int] NULL,
	[Category_desc] [varchar](500) NULL,
	[ParentCategory_Id] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CategoryMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryType]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoryType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_CategoryType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](300) NOT NULL,
	[CityCode] [nvarchar](4) NOT NULL,
	[StateID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_GBSCities] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CommandMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommandMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NULL,
	[Descripition] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[Addedby] [int] NULL,
	[Addedon] [datetime] NULL,
	[Updatedby] [int] NULL,
	[UndatedOn] [datetime] NULL,
 CONSTRAINT [PK_CommandMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CountryMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [nvarchar](2) NULL,
	[CountryName] [nvarchar](255) NULL,
	[AllowBilling] [bit] NULL,
	[AllowShiping] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_GBSCountry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeptMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeptMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeptName] [varchar](50) NULL,
	[DeptCode] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[Modifiedby] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_DeptMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DepuMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepuMaster](
	[Depu_Id] [int] IDENTITY(1,1) NOT NULL,
	[Depu_Name] [varchar](50) NULL,
	[Depu_Location] [varchar](50) NULL,
	[Depot_Code] [varchar](50) NULL,
	[IsParent] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[CommandId] [int] NULL,
	[FormationId] [int] NULL,
	[Corp] [varchar](100) NULL,
	[DepotNo] [varchar](50) NULL,
	[IDT] [varchar](50) NULL,
	[ICT] [varchar](50) NULL,
	[AWS] [varchar](50) NULL,
	[UnitName] [varchar](500) NULL,
 CONSTRAINT [PK_DepuMaster] PRIMARY KEY CLUSTERED 
(
	[Depu_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ESLIssue]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ESLIssue](
	[EslID] [int] IDENTITY(1,1) NOT NULL,
	[BID] [int] NULL,
	[IssueTo] [varchar](50) NOT NULL,
	[Quantitytype] [varchar](50) NULL,
	[Quantity] [varchar](50) NULL,
	[StatusID] [int] NULL,
	[RemarksBynurGP] [varchar](50) NULL,
	[RemarksByjcoiGP] [varchar](50) NULL,
	[RemarksByjDSO] [varchar](50) NULL,
	[OverallRemarks] [varchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[Addedby] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[SentOn] [datetime] NULL,
	[RecievedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ESLIssue] PRIMARY KEY CLUSTERED 
(
	[EslID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EslMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EslMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NULL,
	[Unit_Id] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Esl] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExpenseVoucherMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExpenseVoucherMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[ProductID] [int] NULL,
	[BatchID] [int] NULL,
	[UsedQty] [decimal](36, 3) NULL,
	[UsedFromFullPackets] [decimal](36, 3) NULL,
	[FormatFull] [varchar](max) NULL,
	[FormatLoose] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[RemainingQty] [decimal](36, 3) NULL,
	[ExpenseVoucherNo] [varchar](max) NULL,
 CONSTRAINT [PK_ExpenseVoucherMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Formation]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Formation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NULL,
	[Descripition] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[Addedby] [int] NULL,
	[Addedon] [datetime] NULL,
	[Updatedby] [int] NULL,
	[UndatedOn] [datetime] NULL,
	[CommandId] [int] NULL,
 CONSTRAINT [PK_Formation ] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForwardNoteMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForwardNoteMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[batchId] [int] NULL,
	[forwardingNoteNumber] [varchar](500) NULL,
	[forwardNoteDate] [datetime] NULL,
	[officerDesignation] [varchar](100) NULL,
	[officerPostalAddress] [varchar](700) NULL,
	[addressee] [varchar](700) NULL,
	[nomenStore] [varchar](200) NULL,
	[containerType] [varchar](200) NULL,
	[sampleRefNumber] [varchar](500) NULL,
	[sampleIdentificationMarks] [varchar](200) NULL,
	[sampleQualtity] [decimal](10, 3) NULL,
	[numberOfSamples] [int] NULL,
	[sampleType] [varchar](200) NULL,
	[dispatchDate] [datetime] NULL,
	[dispatchMethod] [varchar](500) NULL,
	[sampleDrawnDate] [datetime] NULL,
	[drawerNameAndRank] [varchar](700) NULL,
	[quantityRepressntedBySample] [decimal](12, 3) NULL,
	[intendedDestination] [varchar](700) NULL,
	[fillingDate] [datetime] NULL,
	[iNoteNumber] [varchar](200) NULL,
	[iNoteDate] [datetime] NULL,
	[previousTestReferences] [varchar](500) NULL,
	[tankNumber] [varchar](200) NULL,
	[containerMarkingDetails] [varchar](200) NULL,
	[tradeOwned] [varchar](100) NULL,
	[govtStock] [varchar](100) NULL,
	[tradeGovtAccepted] [varchar](100) NULL,
	[reasonForTest] [varchar](max) NULL,
	[governingSupply] [varchar](500) NULL,
	[atNoReferences] [varchar](500) NULL,
	[isForwardingNoteActive] [int] NULL,
	[OldEslDate] [datetime] NULL,
	[EslModifyDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GateInout]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GateInout](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[vehbano] [varchar](50) NULL,
	[franchiseeno] [varchar](50) NULL,
	[ArmyNo] [varchar](50) NULL,
	[rank] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[timein] [datetime] NULL,
	[typeofvehicle] [varchar](50) NULL,
	[unitQuantityTypeId] [int] NULL,
	[loadin] [varchar](50) NULL,
	[IdtId] [int] NULL,
	[timeout] [datetime] NULL,
	[loadout] [varchar](50) NULL,
	[stationDepuID] [int] NULL,
	[stationUnitId] [int] NULL,
	[fuelintankIn] [varchar](50) NULL,
	[fuelintankOut] [varchar](50) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_GateInout] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GatInOut]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GatInOut](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsLoadIn] [bit] NULL,
	[Recievedfrom] [varchar](50) NULL,
	[vehbano] [varchar](50) NULL,
	[franchiseeno] [varchar](50) NULL,
	[ArmyNo] [varchar](50) NULL,
	[rank] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[timein] [datetime] NULL,
	[typeofvehicle] [varchar](50) NULL,
	[unitQuantityTypeId] [varchar](50) NULL,
	[loadin] [varchar](50) NULL,
	[IdtId] [varchar](50) NULL,
	[timeout] [datetime] NULL,
	[loadout] [varchar](50) NULL,
	[stationDepuID] [varchar](50) NULL,
	[stationUnitId] [varchar](50) NULL,
	[fuelintankIn] [varchar](50) NULL,
	[fuelintankOut] [varchar](50) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_GatInOut] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gh]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[gh](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[a] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IDT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IDT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IndentName] [varchar](100) NULL,
	[IsApproved] [bit] NULL,
	[IsIssueVoucherId] [bit] NULL,
	[IsTallySheetId] [bit] NULL,
	[IsGateOut] [bit] NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Indent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IssueVoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IssueVoucher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdtId] [int] NULL,
	[ToDepuId] [int] NULL,
	[ToUnitId] [int] NULL,
	[VechileNo] [varchar](50) NULL,
	[Authority] [varchar](50) NULL,
	[Through] [varchar](100) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_IssueVoucher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ManuMgmt]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ManuMgmt](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ManuName] [varchar](max) NULL,
	[ManuLink] [varchar](max) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ManuMgmt] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OriginalManufacture ]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OriginalManufacture ](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[ContactNo] [numeric](18, 0) NULL,
	[IsActivated] [bit] NULL,
 CONSTRAINT [PK_OriginalManufacture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMandContainerMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMandContainerMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [varchar](500) NULL,
	[Capacity] [varchar](500) NULL,
	[Grade] [varchar](500) NULL,
	[Condition] [varchar](500) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_PMandContainerMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMCapacity]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMCapacity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Capacity] [numeric](18, 0) NULL,
	[Unit] [varchar](500) NULL,
	[AddedOn] [datetime] NULL,
	[Modified] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PMCapacity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMCondition]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMCondition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Condition] [varchar](500) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PMCondition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMGrade]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMGrade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Grade] [varchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PMGrade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMNames]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMNames](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PMNames] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductMaster](
	[Product_ID] [int] IDENTITY(1,1) NOT NULL,
	[Product_Name] [varchar](50) NULL,
	[Product_Desc] [varchar](500) NULL,
	[Short_Product_Desc] [varchar](200) NULL,
	[Admin_Remarks] [varchar](50) NULL,
	[product_cost] [decimal](18, 0) NULL,
	[Product_Code] [varchar](50) NULL,
	[Category_Id] [int] NULL,
	[AddedOn] [datetime] NULL,
	[MfgDate] [datetime] NULL,
	[ExpDate] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[StockQty] [numeric](18, 0) NULL,
	[IsProductStatus] [varchar](50) NULL,
	[Cat] [varchar](max) NULL,
	[productUnit] [varchar](100) NULL,
	[GSreservre] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuantityType]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuantityType](
	[Id] [varchar](50) NOT NULL,
	[QuantityType] [varchar](50) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_QuantityType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RecievedFrom]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecievedFrom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecievedFrom] [varchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_RecievedFrom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[Role_ID] [int] IDENTITY(1,1) NOT NULL,
	[Role_Code] [varchar](50) NULL,
	[Role] [varchar](50) NULL,
	[Role_Desc] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[DeptId] [int] NULL,
	[Rank] [int] NULL,
 CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[Role_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatesMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatesMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SUName] [nvarchar](255) NULL,
	[SUCountry] [nvarchar](2) NULL,
	[SUCode] [nvarchar](4) NULL,
	[CountryID] [int] NULL,
	[ZoneID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_GBSStates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StatusMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatusMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](50) NULL,
	[CreateedOn] [date] NULL,
	[UpdatedOn] [date] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_StatusMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stock_BatchMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stock_BatchMaster](
	[BatchId] [int] IDENTITY(1,1) NOT NULL,
	[BatchName] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[WarehouseSectionId] [varchar](50) NULL,
	[MfgDate] [date] NULL,
	[ExpDate] [date] NULL,
	[EslDate] [date] NULL,
 CONSTRAINT [PK_Stock_BatchMaster] PRIMARY KEY CLUSTERED 
(
	[BatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stock_QuantityMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock_QuantityMaster](
	[Id] [int] NOT NULL,
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Stock_QuantityMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stock_StockIn]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stock_StockIn](
	[StockInId] [int] IDENTITY(1,1) NOT NULL,
	[LotBatchId] [int] NULL,
	[DateOfReceipt] [date] NULL,
	[CrvNumber] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[ReceivedFrom] [varchar](50) NULL,
	[PackingMaterialName] [varchar](50) NULL,
	[OriginalManufacture] [varchar](50) NULL,
	[GenericName] [varchar](50) NULL,
	[Weight] [decimal](18, 0) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [date] NULL,
 CONSTRAINT [PK_StockIn] PRIMARY KEY CLUSTERED 
(
	[StockInId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockMaster](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [decimal](18, 3) NULL,
	[MinQuantity] [varchar](1000) NULL,
	[QuantityType] [varchar](50) NULL,
	[BID] [int] NULL,
	[IsActive] [bit] NULL,
	[IsStockIn] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IssueQty] [decimal](18, 3) NULL,
	[SupplierId] [int] NULL,
	[GenericName] [varchar](50) NULL,
	[OriginalManf] [varchar](50) NULL,
	[SentQty] [numeric](18, 0) NULL,
	[RecievedOn] [datetime] NULL,
	[DriverName] [varchar](100) NULL,
	[InterTransferId] [int] NULL,
	[Remarks] [varchar](max) NULL,
	[ChallanOrIrNo] [varchar](50) NULL,
	[IsChallanNo] [bit] NULL,
	[IsIrNo] [bit] NULL,
	[PackingMaterial] [varchar](max) NULL,
	[UnitInfo] [varchar](100) NULL,
	[ATNo] [varchar](max) NULL,
	[RecievedFrom] [varchar](50) NULL,
	[OtherSupplier] [varchar](50) NULL,
	[TransferedBy] [varchar](50) NULL,
	[SampleSent] [bit] NULL,
	[ContactNo] [varchar](50) NULL,
	[ProductId] [int] NULL,
	[CostOfParticular] [float] NULL,
	[PackagingMaterialShape] [varchar](50) NULL,
	[PackagingMaterialSize] [varchar](50) NULL,
	[PackagingMaterialFormatLevel] [int] NULL,
	[PackingMaterialFormat] [varchar](max) NULL,
	[CRVNo] [varchar](max) NULL,
	[SupplierNo] [varchar](max) NULL,
	[Weight] [decimal](18, 3) NULL,
	[WeigthUnit] [varchar](50) NULL,
	[ShapeUnit] [varchar](50) NULL,
	[PMGradeId] [int] NULL,
	[PMCapacityId] [int] NULL,
	[PMConditionId] [int] NULL,
	[IsEmptyPM] [bit] NULL,
	[IsWithoutPacking] [bit] NULL,
	[IsSubPacking] [bit] NULL,
	[IsDW] [bit] NULL,
	[SubPMName] [varchar](max) NULL,
	[SubPMGradeId] [int] NULL,
	[SubPMCapacityId] [int] NULL,
	[SubPMConditionId] [int] NULL,
	[SubPMShape] [varchar](50) NULL,
	[SubPMSize] [varchar](50) NULL,
	[SubWeight] [decimal](18, 3) NULL,
	[SubWeightUnit] [varchar](50) NULL,
	[SubShapeUnit] [varchar](50) NULL,
	[Session] [datetime] NULL,
 CONSTRAINT [PK_StockMaster] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockPakaging]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockPakaging](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PackagingType] [varchar](50) NOT NULL,
	[StockBatchId] [int] NOT NULL,
	[RemainingQty] [decimal](18, 3) NOT NULL,
	[Format] [varchar](max) NOT NULL,
 CONSTRAINT [PK_StockPakaging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockSpillage]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockSpillage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockId] [int] NOT NULL,
	[StockBatchId] [int] NOT NULL,
	[SpilledQty] [decimal](36, 18) NOT NULL,
	[DamagedBoxes] [decimal](36, 0) NOT NULL,
	[SpillageAffected] [decimal](36, 0) NOT NULL,
	[SampleAffected] [decimal](36, 0) NOT NULL,
	[BothAffected] [decimal](36, 0) NOT NULL,
 CONSTRAINT [PK_StockSpillage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockTransfer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTransfer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DepuMasterId] [int] NULL,
	[IsUnit] [bit] NULL,
	[UnitMasterId] [int] NULL,
	[CategoryTypeID] [int] NULL,
	[CategoryMasterId] [int] NULL,
	[ProductMasterId] [int] NULL,
	[BatchMasterId] [int] NULL,
	[TypeOfOrderId] [int] NULL,
	[IndentId] [int] NULL,
	[QtyIssued] [decimal](18, 0) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_StockTransfer_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockVehicle]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockVehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockID] [int] NOT NULL,
	[DriverName] [varchar](50) NOT NULL,
	[VehicleNo] [varchar](50) NOT NULL,
	[StockBatchId] [int] NOT NULL,
	[SentQty] [decimal](18, 3) NOT NULL,
	[RecievedQty] [decimal](18, 3) NOT NULL,
	[ChallanNo] [varchar](50) NULL,
	[IsDDOrCHT] [varchar](50) NULL,
 CONSTRAINT [PK_StockVehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[supplier](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[IsActivated] [bit] NULL,
	[ContactNo] [numeric](18, 0) NULL,
 CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TallySheet]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TallySheet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdtId] [int] NULL,
	[DepuIdFrom] [int] NULL,
	[UnitIdFrom] [int] NULL,
	[ToDepuId] [int] NULL,
	[ToUnitId] [int] NULL,
	[Authority] [varchar](50) NULL,
	[Through] [varchar](50) NULL,
	[VehBaNo] [varchar](50) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TallySheet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Atttribute]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tbl_Atttribute](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [varchar](500) NULL,
	[Active] [int] NULL,
	[CreateduserId] [int] NULL,
	[Createddate] [datetime] NULL,
	[ModifieduserId] [int] NULL,
	[Modifieddate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Authority]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Authority](
	[AuId] [int] IDENTITY(500,1) NOT NULL,
	[AuthorityName] [varchar](500) NOT NULL,
	[Active] [bit] NULL,
	[Fyear] [int] NULL,
	[Qid] [int] NULL,
	[OrderType] [int] NULL,
	[Createddate] [datetime] NOT NULL,
	[modifieddate] [datetime] NOT NULL,
	[Createduserid] [int] NULL,
	[modifieduserid] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_batchIdt]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_batchIdt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[BatchName] [varchar](50) NULL,
	[issueqty] [decimal](36, 11) NULL,
	[DepuID] [int] NULL,
	[ProductID] [int] NULL,
	[Qid] [int] NULL,
	[createddate] [datetime] NULL,
	[issueorder_Status] [int] NULL,
	[IssueOrderId] [int] NULL,
	[BID] [int] NULL,
	[Remarks] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_financialyear]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_financialyear](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FYID] [int] NULL,
	[FyidRange] [varchar](200) NULL,
	[IsActive] [bit] NULL,
	[createddate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_idtQty_Quarter]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_idtQty_Quarter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pid] [int] NULL,
	[Product_Name] [varchar](500) NULL,
	[Qid] [int] NULL,
	[QuarterRange] [varchar](500) NULL,
	[dipu] [varchar](200) NULL,
	[dipuid] [int] NULL,
	[IDTqty] [int] NULL,
	[left_IDTqty] [int] NULL,
	[fyid] [int] NULL,
	[Isactive] [bit] NULL,
	[createddate] [datetime] NULL,
	[modifieddate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_IDTrefrence]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_IDTrefrence](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[depuid] [int] NULL,
	[refrence_letterNo] [varchar](200) NULL,
	[refrenceDate] [datetime] NULL,
	[Remarks] [nvarchar](max) NULL,
	[Createddate] [datetime] NULL,
	[Qid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_IssueOrder]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_IssueOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IssueOrderId] [int] NULL,
	[IssueOrderNo] [varchar](500) NULL,
	[DepotId] [int] NULL,
	[QuarterId] [int] NULL,
	[OrderStatusId] [int] NULL,
	[Active] [int] NULL,
	[CreateDate] [datetime] NULL,
	[createduserid] [int] NULL,
	[Authority] [varchar](200) NULL,
	[issueorder_date] [datetime] NULL,
	[productID] [int] NULL,
	[issuequantity] [int] NULL,
	[IDTICTAWS] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_IssueVoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_IssueVoucher](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[categoryID] [int] NULL,
	[Through] [varchar](200) NULL,
	[Authority] [varchar](200) NULL,
	[PID] [int] NULL,
	[PMID] [int] NULL,
	[PMquantity] [int] NULL,
	[quantity] [int] NULL,
	[VechileID] [int] NULL,
	[VechileName] [varchar](500) NULL,
	[IssueQuantity] [int] NULL,
	[Createdate] [datetime] NULL,
	[modifieddate] [datetime] NULL,
	[craeteduserID] [int] NULL,
	[ModifieduserID] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_issuevoucherdetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_issuevoucherdetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IssueorderId] [int] NULL,
	[IssusevoucherName] [varchar](100) NULL,
	[Active] [bit] NULL,
	[Createddate] [datetime] NULL,
	[Createdby] [int] NULL,
	[Modifieddate] [datetime] NULL,
	[Modifiedby] [int] NULL,
	[Cat_ID] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_loadtallydetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_loadtallydetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[loadtallyNumber] [nvarchar](max) NULL,
	[IssueorderId] [int] NULL,
	[vechileNo] [nvarchar](max) NULL,
	[DriverName] [varchar](500) NULL,
	[Rank] [varchar](200) NULL,
	[UnitNo] [varchar](200) NULL,
	[DateofGenration] [datetime] NULL,
	[Active] [bit] NULL,
	[Createdby] [int] NULL,
	[Createddate] [datetime] NULL,
	[Modifiedby] [int] NULL,
	[Modifieddate] [datetime] NULL,
	[Authority] [varchar](500) NULL,
	[Through] [varchar](500) NULL,
	[LoadtallyId] [int] NULL,
	[Remarks] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_loadtaly]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_loadtaly](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[loadtallyNumber] [nvarchar](max) NULL,
	[IssueorderId] [int] NULL,
	[vechileNo] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[Createdby] [int] NULL,
	[Createddate] [datetime] NULL,
	[Modifiedby] [int] NULL,
	[Modifieddate] [datetime] NULL,
	[loadtally_status] [int] NULL,
	[Remarks] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ProductIDT_Quantity]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ProductIDT_Quantity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NULL,
	[Product_Name] [varchar](200) NULL,
	[Dipu] [varchar](200) NULL,
	[Dipuprd_IDTqty] [int] NULL,
	[IsActive] [bit] NULL,
	[createddate] [datetime] NULL,
	[modifieddate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_QuarterRange]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_QuarterRange](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuarterRangeValue] [int] NULL,
	[QuarterRange] [varchar](500) NULL,
	[FYID] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_vechileMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_vechileMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Through] [varchar](500) NULL,
	[VechileNumber] [varchar](500) NULL,
	[DriverName] [varchar](500) NULL,
	[Rank] [varchar](500) NULL,
	[IsActive] [int] NULL,
	[Createddate] [datetime] NULL,
	[CreateduserId] [int] NULL,
	[Modifieddate] [datetime] NULL,
	[Modifieduserid] [int] NULL,
	[loadtallystatus] [int] NULL,
	[ArmyNo] [varchar](500) NULL,
	[vechileType] [int] NULL,
	[unitNo] [varchar](500) NULL,
	[LicenseNo] [varchar](500) NULL,
	[Remarks] [varchar](1000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_vechileMaster_Type]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_vechileMaster_Type](
	[VtypeId] [int] IDENTITY(1,1) NOT NULL,
	[Vtypename] [varchar](500) NULL,
	[Isactive] [int] NULL,
	[Createddate] [datetime] NULL,
	[Modifieddate] [datetime] NULL,
	[Createduserid] [int] NULL,
	[ModifieduserId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblExpensePMContainer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblExpensePMContainer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseVoucherNo] [varchar](max) NOT NULL,
	[PMContainerId] [int] NOT NULL,
	[Quantity] [decimal](36, 3) NULL,
	[IsSentfromCP] [bit] NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[Remarks] [varchar](max) NULL,
 CONSTRAINT [PK_tblExpensePMContainer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblIssueVoucherDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblIssueVoucherDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IssueOrderId] [varchar](50) NULL,
	[IssueVoucherName] [varchar](50) NULL,
	[DateOfGeneratation] [datetime] NULL,
	[Active] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_tblIssueVoucherDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblIssueVoucherVehicleDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblIssueVoucherVehicleDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IssueVoucherId] [varchar](500) NULL,
	[ProductId] [int] NULL,
	[VehicleNo] [varchar](50) NULL,
	[PMQuantity] [decimal](9, 2) NULL,
	[StockQuantity] [decimal](36, 11) NULL,
	[VoucherRemarks] [varchar](max) NULL,
	[Active] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[dateofgenration] [datetime] NULL,
	[Through] [varchar](200) NULL,
	[issueVoucher_status] [int] NULL,
	[Cat_ID] [int] NULL,
	[issueorderID] [int] NULL,
	[batchno] [varchar](500) NULL,
	[FormatFull] [varchar](max) NULL,
	[FormatLoose] [varchar](max) NULL,
	[BID] [int] NULL,
	[FullOccupied] [bit] NULL,
	[VehicleId] [int] NULL,
 CONSTRAINT [PK_tblIssueVoucherVehicleDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLPCP]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLPCP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsATNo] [bit] NOT NULL,
	[IsSONo] [bit] NOT NULL,
	[ATSONo] [varchar](500) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[SupplierContactNo] [varchar](50) NULL,
	[TenderDate] [datetime] NOT NULL,
	[LDPer] [decimal](36, 2) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [decimal](36, 18) NOT NULL,
	[OriginalMfgID] [int] NOT NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[DeliveryTime] [datetime] NOT NULL,
	[Rate] [decimal](36, 18) NOT NULL,
	[Value] [decimal](36, 18) NOT NULL,
	[Status] [bit] NOT NULL,
	[Late] [bit] NOT NULL,
	[Dispute] [bit] NOT NULL,
	[Other] [bit] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[AddedBy] [int] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[Remarks] [varchar](max) NULL,
 CONSTRAINT [PK_tblLPCP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblQuarter]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuarter](
	[QuarterId] [int] IDENTITY(1,1) NOT NULL,
	[QuarterName] [varchar](50) NULL,
	[QuarterYear] [int] NULL,
	[QuarterRank] [int] NULL,
	[YearRange] [varchar](500) NULL,
 CONSTRAINT [PK_tblQuarter] PRIMARY KEY CLUSTERED 
(
	[QuarterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSection]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Section] [varchar](500) NULL,
	[SubSection] [varchar](500) NULL,
	[IsParent] [int] NULL,
	[Row] [int] NULL,
	[Col] [int] NULL,
	[Drawers] [int] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
	[WarehouseID] [int] NULL,
 CONSTRAINT [PK_tblSection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblWarehouse]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblWarehouse](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WareHouseNo] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_tblWarehouse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TypeOfOrder]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TypeOfOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TypeOfOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnitMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnitMaster](
	[Unit_Id] [int] IDENTITY(1,1) NOT NULL,
	[Depu_Id] [int] NULL,
	[Unit_Name] [varchar](50) NULL,
	[Unit_Code] [varchar](50) NULL,
	[Unit_Desc] [varchar](max) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[Command] [int] NULL,
	[Formation] [int] NULL,
	[UnitType] [int] NULL,
 CONSTRAINT [PK_UnitMaster] PRIMARY KEY CLUSTERED 
(
	[Unit_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnitType]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnitType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_UnitType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[UserCode] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[User_Name] [varchar](50) NULL,
	[RoleId] [int] NULL,
	[Password] [varchar](50) NULL,
	[Country] [int] NULL,
	[State] [int] NULL,
	[City] [int] NULL,
	[Address] [varchar](500) NULL,
	[ContactNo] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[Addedon] [datetime] NULL,
	[AddedBy] [int] NULL,
	[Modifiedon] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ArmyNo] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AddPMContainer] ON 

INSERT [dbo].[AddPMContainer] ([ID], [PMID], [Quantity], [DateOfReceival], [AddedOn], [AddedBy], [ModidfiedOn], [ModifiedBy], [CategoryID]) VALUES (1, 1, CAST(22.000 AS Decimal(36, 3)), CAST(N'2016-06-25 00:00:00.000' AS DateTime), CAST(N'2016-06-25 00:13:35.893' AS DateTime), 1, CAST(N'2016-06-25 00:19:57.197' AS DateTime), 1, 2)
SET IDENTITY_INSERT [dbo].[AddPMContainer] OFF
SET IDENTITY_INSERT [dbo].[BatchMaster] ON 

INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (1, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2016-12-31 00:00:00.000' AS DateTime), 1, NULL, NULL, CAST(N'2016-06-29 06:35:08.023' AS DateTime), NULL, NULL, NULL, CAST(N'2016-06-30 00:00:00.000' AS DateTime), 0, N'Fit', 2, N'', N'', CAST(89250.00 AS Decimal(36, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(2975.000000000000000000 AS Decimal(36, 18)), CAST(0.500000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (2, NULL, NULL, NULL, N'B2', NULL, NULL, NULL, NULL, CAST(N'2016-06-01 00:00:00.000' AS DateTime), CAST(N'2017-06-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-06-19 00:00:00.000' AS DateTime), 0, N'Fit', 2, N'', N'', CAST(79400.00 AS Decimal(36, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(1985.000000000000000000 AS Decimal(36, 18)), CAST(0.500000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (3, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-06-01 00:00:00.000' AS DateTime), CAST(N'2017-06-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-06-19 00:00:00.000' AS DateTime), 0, N'Fit', 3, N'', N'', CAST(49400.00 AS Decimal(36, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(4940.000000000000000000 AS Decimal(36, 18)), CAST(1.000000000000000000 AS Decimal(36, 18)), N'', N'WH3', NULL, 3, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-06-15 00:00:00.000' AS DateTime), CAST(N'2016-12-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-19 00:00:00.000' AS DateTime), 0, N'Fit', 4, N'', N'', CAST(450000.00 AS Decimal(36, 2)), CAST(150.00 AS Decimal(18, 2)), CAST(6000.000000000000000000 AS Decimal(36, 18)), CAST(2.000000000000000000 AS Decimal(36, 18)), N'', N'WH4', NULL, 4, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (5, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-03-01 00:00:00.000' AS DateTime), CAST(N'2017-03-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-19 00:00:00.000' AS DateTime), 0, N'Fit', 5, N'', N'', CAST(884000.00 AS Decimal(36, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(132600.000000000000000000 AS Decimal(36, 18)), CAST(30.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (6, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2019-06-29 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2019-05-19 00:00:00.000' AS DateTime), 0, N'Fit', 6, N'', N'', CAST(70000000.00 AS Decimal(36, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(700000.000000000000000000 AS Decimal(36, 18)), CAST(500.000000000000000000 AS Decimal(36, 18)), N'', N'WH3', NULL, 3, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (7, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-06-01 00:00:00.000' AS DateTime), CAST(N'2016-12-31 00:00:00.000' AS DateTime), 1, NULL, NULL, CAST(N'2016-06-30 03:20:53.300' AS DateTime), NULL, NULL, NULL, CAST(N'2017-06-30 00:00:00.000' AS DateTime), 0, N'Fit', 7, N'', N'', CAST(70000.00 AS Decimal(36, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(1750000.000000000000000000 AS Decimal(36, 18)), CAST(250.000000000000000000 AS Decimal(36, 18)), N'', N'WH4', NULL, 4, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (8, NULL, NULL, NULL, N'Batch01', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-03-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-02-21 00:00:00.000' AS DateTime), 0, N'Fit', 8, N'', N'', CAST(500000.00 AS Decimal(36, 2)), CAST(500.00 AS Decimal(18, 2)), CAST(1000.000000000000000000 AS Decimal(36, 18)), CAST(1.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (9, NULL, NULL, NULL, N'Batch02', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-03-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-02-21 00:00:00.000' AS DateTime), 0, N'Fit', 8, N'', N'', CAST(660000.00 AS Decimal(36, 2)), CAST(600.00 AS Decimal(18, 2)), CAST(1100.000000000000000000 AS Decimal(36, 18)), CAST(1.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (10, NULL, NULL, NULL, N'Batch1', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2018-06-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-24 00:00:00.000' AS DateTime), 1, N'Fit', 9, N'', N'', CAST(98200.00 AS Decimal(36, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(4910.000000000000000000 AS Decimal(36, 18)), CAST(1.000000000000000000 AS Decimal(36, 18)), N'', N'WH3', CAST(50.000000000000000000 AS Decimal(36, 18)), 3, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (11, NULL, NULL, NULL, N'Batch2', NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime), CAST(N'2017-12-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-11-24 00:00:00.000' AS DateTime), 1, N'Fit', 9, N'', N'', CAST(116400.00 AS Decimal(36, 2)), CAST(30.00 AS Decimal(18, 2)), CAST(3880.000000000000000000 AS Decimal(36, 18)), CAST(1.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', CAST(60.000000000000000000 AS Decimal(36, 18)), 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (12, NULL, NULL, NULL, N'TestB1', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2016-12-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-11-23 00:00:00.000' AS DateTime), 1, NULL, 10, N'', N'', CAST(123500.00 AS Decimal(36, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(4750.000000000000000000 AS Decimal(36, 18)), CAST(0.500000000000000000 AS Decimal(36, 18)), N'', N'WH2', CAST(100.000000000000000000 AS Decimal(36, 18)), 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (13, NULL, NULL, NULL, N'TestB2', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-04-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-02-23 00:00:00.000' AS DateTime), 1, NULL, 10, N'', N'', CAST(136500.00 AS Decimal(36, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(5250.000000000000000000 AS Decimal(36, 18)), CAST(0.500000000000000000 AS Decimal(36, 18)), N'', N'WH4', CAST(100.000000000000000000 AS Decimal(36, 18)), 4, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (14, NULL, NULL, NULL, N'TestB3', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-07-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, NULL, 10, N'', N'', CAST(104000.00 AS Decimal(36, 2)), CAST(13.00 AS Decimal(18, 2)), CAST(4000.000000000000000000 AS Decimal(36, 18)), CAST(0.500000000000000000 AS Decimal(36, 18)), N'', N'WH1', CAST(100.000000000000000000 AS Decimal(36, 18)), 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (15, NULL, NULL, NULL, N'Batch03', NULL, NULL, NULL, NULL, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2017-12-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-10-03 00:00:00.000' AS DateTime), 1, NULL, 11, N'', N'', CAST(990000.00 AS Decimal(36, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(99000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH4', CAST(10.000000000000000000 AS Decimal(36, 18)), 4, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (16, NULL, NULL, NULL, N'Batch04', NULL, NULL, NULL, NULL, CAST(N'2016-03-01 00:00:00.000' AS DateTime), CAST(N'2017-06-30 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-03 00:00:00.000' AS DateTime), 1, NULL, 11, N'', N'', CAST(445500.00 AS Decimal(36, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(49500.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH3', CAST(10.000000000000000000 AS Decimal(36, 18)), 3, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (17, NULL, NULL, NULL, N'B1', NULL, NULL, NULL, NULL, CAST(N'2016-08-01 00:00:00.000' AS DateTime), CAST(N'2016-08-31 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-08-17 00:00:00.000' AS DateTime), 0, NULL, 12, N'', N'', CAST(25000.00 AS Decimal(36, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(50000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (18, NULL, NULL, NULL, N'thi', NULL, NULL, NULL, NULL, CAST(N'2016-10-10 00:00:00.000' AS DateTime), CAST(N'2016-10-24 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-27 00:00:00.000' AS DateTime), 0, NULL, 14, N'', N'', CAST(2000.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(21000.000000000000000000 AS Decimal(36, 18)), CAST(21.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (19, NULL, NULL, NULL, N'kjiij', NULL, NULL, NULL, NULL, CAST(N'2016-09-01 00:00:00.000' AS DateTime), CAST(N'2016-09-01 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-09-01 00:00:00.000' AS DateTime), 0, NULL, 11, N'', N'', CAST(1221.00 AS Decimal(36, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(394383.000000000000000000 AS Decimal(36, 18)), CAST(323.000000000000000000 AS Decimal(36, 18)), N'', N'1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (20, NULL, NULL, NULL, N'batch test loose', NULL, NULL, NULL, NULL, CAST(N'2016-09-03 00:00:00.000' AS DateTime), CAST(N'2016-09-03 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-09-03 00:00:00.000' AS DateTime), 0, NULL, 12, N'', N'', CAST(1000.00 AS Decimal(36, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(95.238095238095200000 AS Decimal(36, 18)), CAST(0.095238095238095200 AS Decimal(36, 18)), N'', N'1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (21, NULL, NULL, NULL, N'a', NULL, NULL, NULL, NULL, CAST(N'2016-10-08 00:00:00.000' AS DateTime), CAST(N'2016-10-09 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-10-09 00:00:00.000' AS DateTime), 0, NULL, 13, N'', N'hi', CAST(2006.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(21063.000000000000000000 AS Decimal(36, 18)), CAST(21.000000000000000000 AS Decimal(36, 18)), N'', N'1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (1018, NULL, NULL, NULL, N'loveleet koti', NULL, NULL, NULL, NULL, CAST(N'2016-11-06 00:00:00.000' AS DateTime), CAST(N'2016-11-07 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-05 00:00:00.000' AS DateTime), 0, NULL, 1014, N'', N'', CAST(1000.00 AS Decimal(36, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(10000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (1019, NULL, NULL, NULL, N'loveleet koti', NULL, NULL, NULL, NULL, CAST(N'2016-11-06 00:00:00.000' AS DateTime), CAST(N'2016-11-07 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-05 00:00:00.000' AS DateTime), 0, NULL, 1015, N'', N'', CAST(3000.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(15000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (2018, NULL, NULL, NULL, N'kn', NULL, NULL, NULL, NULL, CAST(N'2016-12-01 00:00:00.000' AS DateTime), CAST(N'2016-12-01 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-01 00:00:00.000' AS DateTime), 0, NULL, 2014, N'', N'hi', CAST(800.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(4800.000000000000000000 AS Decimal(36, 18)), CAST(12.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, 1, 1)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (2019, NULL, NULL, NULL, N'lm', NULL, NULL, NULL, NULL, CAST(N'2016-12-01 00:00:00.000' AS DateTime), CAST(N'2016-12-01 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-12-01 00:00:00.000' AS DateTime), 0, NULL, 2014, N'', N'', CAST(400.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2400.000000000000000000 AS Decimal(36, 18)), CAST(12.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, 1, 1)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (3018, NULL, NULL, NULL, N'kotikotiq', NULL, NULL, NULL, NULL, CAST(N'2017-01-02 00:00:00.000' AS DateTime), CAST(N'2017-01-02 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-01-02 00:00:00.000' AS DateTime), 0, NULL, 3014, N'', N'', CAST(2000.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(10000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (3019, NULL, NULL, NULL, N'lovly', NULL, NULL, NULL, NULL, CAST(N'2017-01-03 00:00:00.000' AS DateTime), CAST(N'2017-01-03 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-01-03 00:00:00.000' AS DateTime), 0, NULL, 3014, N'', N'', CAST(600.00 AS Decimal(36, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(2000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4018, NULL, NULL, NULL, N'12345678', NULL, NULL, NULL, NULL, CAST(N'2017-03-01 00:00:00.000' AS DateTime), CAST(N'2017-03-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-01 00:00:00.000' AS DateTime), 0, NULL, 4014, NULL, N'', NULL, CAST(5.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4019, NULL, NULL, NULL, N'98765432', NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), CAST(N'2017-03-02 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), 0, NULL, 4014, NULL, N'', NULL, CAST(2.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4020, NULL, NULL, NULL, N'first', NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), CAST(N'2017-03-03 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), 0, NULL, 4015, N'', N'', CAST(3000.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(15000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4021, NULL, NULL, NULL, N'second', NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), CAST(N'2017-03-03 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), 0, NULL, 4015, N'', N'', CAST(1800.00 AS Decimal(36, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(9000.000000000000000000 AS Decimal(36, 18)), CAST(10.000000000000000000 AS Decimal(36, 18)), N'', N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4022, NULL, NULL, NULL, N'jio', NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), CAST(N'2017-03-03 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), 0, NULL, 4016, NULL, N'', NULL, CAST(2.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4023, NULL, NULL, NULL, N're', NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), CAST(N'2017-03-03 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-03 00:00:00.000' AS DateTime), 0, NULL, 4016, NULL, N'', NULL, CAST(2.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH2', NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4024, NULL, NULL, NULL, N'sfgh', NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), CAST(N'2017-03-02 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), 0, NULL, 4017, NULL, N'', NULL, CAST(2.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH1', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[BatchMaster] ([BID], [BatchName], [BatchCode], [BatchDesc], [BatchNo], [ATNo], [VechicleNo], [RecievedFrom], [PID], [MFGDate], [EXPDate], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsDeleted], [DepotID], [Esl], [IsSentto], [IsBatchStatus], [StockId], [ContactNo], [Remarks], [Cost], [CostOfParticular], [Weight], [WeightofParticular], [WeightUnit], [WarehouseNo], [SampleSentQty], [WarehouseID], [SectionID], [SectionRows], [SectionCol]) VALUES (4025, NULL, NULL, NULL, N'efs', NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), CAST(N'2017-03-02 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-02 00:00:00.000' AS DateTime), 0, NULL, 4017, NULL, N'', NULL, CAST(2.00 AS Decimal(18, 2)), NULL, NULL, NULL, N'WH3', NULL, 3, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[BatchMaster] OFF
SET IDENTITY_INSERT [dbo].[CategoryMaster] ON 

INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (1, N'CM-1', N'1', 1, N'1', NULL, CAST(N'2016-02-14 16:45:42.400' AS DateTime), 132, CAST(N'2016-02-14 16:50:47.550' AS DateTime), 132, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (2, N'CM-2', N'2', 1, N'2', NULL, CAST(N'2016-02-14 16:46:15.073' AS DateTime), 132, NULL, NULL, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (3, N'CM-3', N'3', 2, N'3', NULL, CAST(N'2016-02-14 16:47:28.230' AS DateTime), 132, NULL, NULL, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (4, N'CM-4', N'4', 3, N'4', NULL, CAST(N'2016-02-14 16:48:33.150' AS DateTime), 132, NULL, NULL, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (5, N'CM-5', N'5', 4, N'5', NULL, CAST(N'2016-02-14 16:50:18.733' AS DateTime), 132, CAST(N'2016-05-07 12:02:48.470' AS DateTime), NULL, 0)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (6, N'CM-6', N'6', 1, N'6', NULL, CAST(N'2016-02-26 19:29:45.977' AS DateTime), 132, CAST(N'2016-03-02 10:38:14.210' AS DateTime), 132, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (7, N'CM-7', N'7', 1, N'7', NULL, CAST(N'2016-02-26 19:30:58.303' AS DateTime), 132, CAST(N'2016-03-02 10:38:36.310' AS DateTime), 132, 1)
INSERT [dbo].[CategoryMaster] ([ID], [Category_Code], [Category_Name], [Category_TypeId], [Category_desc], [ParentCategory_Id], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive]) VALUES (8, N'CM-8', N'8', 1, N'8', NULL, CAST(N'2016-05-07 12:04:12.390' AS DateTime), 132, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CategoryMaster] OFF
SET IDENTITY_INSERT [dbo].[CategoryType] ON 

INSERT [dbo].[CategoryType] ([ID], [Type], [Description], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'1', N'1', 1, CAST(N'2016-02-14 16:42:03.627' AS DateTime), 123, NULL, NULL)
INSERT [dbo].[CategoryType] ([ID], [Type], [Description], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'2', N'2', 0, CAST(N'2016-02-14 16:42:40.253' AS DateTime), 123, NULL, NULL)
INSERT [dbo].[CategoryType] ([ID], [Type], [Description], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'3', N'3', 0, CAST(N'2016-02-14 16:43:40.083' AS DateTime), 123, NULL, NULL)
INSERT [dbo].[CategoryType] ([ID], [Type], [Description], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'4', N'4', 0, CAST(N'2016-02-14 16:44:01.257' AS DateTime), 123, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CategoryType] OFF
SET IDENTITY_INSERT [dbo].[CommandMaster] ON 

INSERT [dbo].[CommandMaster] ([Id], [Name], [Descripition], [IsActive], [Addedby], [Addedon], [Updatedby], [UndatedOn]) VALUES (1, N'first command', N'description', 1, 1, CAST(N'2016-08-25 10:26:31.833' AS DateTime), 1, CAST(N'2016-08-25 10:26:31.833' AS DateTime))
SET IDENTITY_INSERT [dbo].[CommandMaster] OFF
SET IDENTITY_INSERT [dbo].[DeptMaster] ON 

INSERT [dbo].[DeptMaster] ([Id], [DeptName], [DeptCode], [Description], [AddedOn], [AddedBy], [ModifiedOn], [Modifiedby], [IsActive]) VALUES (10, N' Adminstration', N'    DP-1', N'    This is', CAST(N'2015-02-06 14:00:15.917' AS DateTime), 786, CAST(N'2015-02-13 15:20:03.140' AS DateTime), 786, 1)
INSERT [dbo].[DeptMaster] ([Id], [DeptName], [DeptCode], [Description], [AddedOn], [AddedBy], [ModifiedOn], [Modifiedby], [IsActive]) VALUES (11, N' HR', N' DP-11', N' abc', CAST(N'2015-02-06 14:14:43.740' AS DateTime), 786, CAST(N'2015-02-13 15:11:29.817' AS DateTime), 786, 1)
SET IDENTITY_INSERT [dbo].[DeptMaster] OFF
SET IDENTITY_INSERT [dbo].[DepuMaster] ON 

INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (1, N' FPD ASC Khunmoh ', N' Khnmoh, Udhampur', N'DM-1', 0, CAST(N'2016-02-14 12:48:00.943' AS DateTime), 2, CAST(N'2016-04-01 21:33:41.793' AS DateTime), 465, 1, NULL, 2, N'15 Corps', N'405 HQ Coy Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (2, N'FPD ASC Leh ', N'HQ Located at Leh', N'DM-1', 0, CAST(N'2016-02-14 12:51:20.190' AS DateTime), 2, NULL, NULL, 1, NULL, 3, N'14 Corps', N'406 HQ Coy ASC (Pet)', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (3, N'FPD ASC Rajouri', N'Located at Rajouri', N'DM-1', 0, CAST(N'2016-02-14 12:53:47.930' AS DateTime), 2, NULL, NULL, 1, NULL, 4, N'16 Coorps', N'445 Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (4, N'FPD ASC BD Bari', N'BD Bari (Jammu)', N'DM-1', 0, CAST(N'2016-02-14 12:54:40.387' AS DateTime), 2, NULL, NULL, 1, NULL, 4, N'16 Crops', N'236 Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (5, N'212 Pet Pl ASC', N'Located at Udhampur', N'DM-1', 0, CAST(N'2016-02-14 12:55:45.380' AS DateTime), 2, NULL, NULL, 1, NULL, 4, N'16 Corps', N'212 Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (6, N'503 ASC Bn', N'Located at  Leh', N'DM-1', 0, CAST(N'2016-02-14 12:57:03.747' AS DateTime), 2, NULL, NULL, 1, NULL, 3, N'14 Corps', N'503 ASC Bn', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (7, N'     RHPD PAthankot', N'     Pathankot', N'DM-7', 1, CAST(N'2016-02-14 16:40:43.333' AS DateTime), 2, CAST(N'2016-03-04 09:55:51.353' AS DateTime), 465, 1, NULL, 1, N'NA', N'408 HQ Coy ASC (Pet)', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (8, N'5089 Coy ASC (Comp)', N'Batote', N'DM-8', 0, CAST(N'2016-02-15 09:30:38.143' AS DateTime), 2, NULL, NULL, 1, NULL, 6, N'Delta Force', N'5089 Coy ASC (Comp)', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (9, N'726 AD Pl ASC', N'Thoise', N'DM-8', 0, CAST(N'2016-02-15 09:32:15.023' AS DateTime), 2, NULL, NULL, 1, NULL, 3, N'14 Corps', N'726 AD Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (10, N'FOL Depot Ambala', N'Ambala (Punjab)', N'DM-10', 0, CAST(N'2016-02-15 09:34:32.900' AS DateTime), 2, NULL, NULL, 1, NULL, 7, N'WC', N'448 Coy ASC (Pet)', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (11, N' 180 Pet Pl ASC', N' Ambala (Punjab)', N'DM-11', 0, CAST(N'2016-02-15 09:37:12.433' AS DateTime), 2, CAST(N'2016-02-15 09:38:34.100' AS DateTime), 465, 1, NULL, 9, N'2 Corps', N'180 Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (12, N'181 Pet Pl ASC', N'Jalandhar', N'DM-11', 0, CAST(N'2016-02-15 09:39:26.953' AS DateTime), 2, NULL, NULL, 1, NULL, 8, N'11 Corps', N'181 Pet Pl ASC', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (13, N'277 Pet Cont Unit', N'Bathinda', N'DM-13', 0, CAST(N'2016-02-16 20:51:31.663' AS DateTime), 2, NULL, NULL, 1, NULL, 10, N'-', N'277 Pet Cont Unit', N'IDT', N'ICT', N'AWS', NULL)
INSERT [dbo].[DepuMaster] ([Depu_Id], [Depu_Name], [Depu_Location], [Depot_Code], [IsParent], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [CommandId], [FormationId], [Corp], [DepotNo], [IDT], [ICT], [AWS], [UnitName]) VALUES (14, N' RHPD PATHANKOT (NC)', N' Pathankot', N'DM-14', 0, CAST(N'2016-02-22 17:44:12.217' AS DateTime), 2, CAST(N'2016-02-22 17:46:02.747' AS DateTime), 465, 1, NULL, 1, N'15 Corps', N'408 HQ Coy ASC (PET)', N'IDT', N'ICT', N'AWS', NULL)
SET IDENTITY_INSERT [dbo].[DepuMaster] OFF
SET IDENTITY_INSERT [dbo].[ExpenseVoucherMaster] ON 

INSERT [dbo].[ExpenseVoucherMaster] ([ID], [CategoryID], [ProductID], [BatchID], [UsedQty], [UsedFromFullPackets], [FormatFull], [FormatLoose], [Remarks], [AddedOn], [AddedBy], [ModifiedBy], [ModifiedOn], [RemainingQty], [ExpenseVoucherNo]) VALUES (1, 2, 39, 10, CAST(50.000 AS Decimal(36, 3)), CAST(5.000 AS Decimal(36, 3)), N'485X10', N'2|10', N'', CAST(N'2016-06-25 00:19:56.887' AS DateTime), 1, NULL, NULL, CAST(4850.000 AS Decimal(36, 3)), N'evn 25/6/2016')
SET IDENTITY_INSERT [dbo].[ExpenseVoucherMaster] OFF
SET IDENTITY_INSERT [dbo].[Formation] ON 

INSERT [dbo].[Formation] ([Id], [Name], [Descripition], [IsActive], [Addedby], [Addedon], [Updatedby], [UndatedOn], [CommandId]) VALUES (1, N'formation', N'description', 1, 1, CAST(N'2016-08-25 10:27:10.427' AS DateTime), 1, CAST(N'2016-08-25 10:27:10.427' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Formation] OFF
SET IDENTITY_INSERT [dbo].[ForwardNoteMaster] ON 

INSERT [dbo].[ForwardNoteMaster] ([Id], [batchId], [forwardingNoteNumber], [forwardNoteDate], [officerDesignation], [officerPostalAddress], [addressee], [nomenStore], [containerType], [sampleRefNumber], [sampleIdentificationMarks], [sampleQualtity], [numberOfSamples], [sampleType], [dispatchDate], [dispatchMethod], [sampleDrawnDate], [drawerNameAndRank], [quantityRepressntedBySample], [intendedDestination], [fillingDate], [iNoteNumber], [iNoteDate], [previousTestReferences], [tankNumber], [containerMarkingDetails], [tradeOwned], [govtStock], [tradeGovtAccepted], [reasonForTest], [governingSupply], [atNoReferences], [isForwardingNoteActive], [OldEslDate], [EslModifyDate]) VALUES (1, 1, N'FN01', CAST(N'2016-06-25 00:00:00.000' AS DateTime), N'Colonel', NULL, N'Quality Test Centre, Chandigarh', N'QTS CHD', N'Drum', N'None', N'none', CAST(45.000 AS Decimal(10, 3)), 1, N'normal Composite', CAST(N'2016-06-25 00:00:00.000' AS DateTime), N'Flight AI 308', CAST(N'2016-06-25 00:00:00.000' AS DateTime), N'Rohit, QA', CAST(45.000 AS Decimal(12, 3)), N'QTS CHD', CAST(N'2016-06-24 00:00:00.000' AS DateTime), N'Inventory 123', CAST(N'2016-06-01 00:00:00.000' AS DateTime), N'none', N't123', N'none', N'yes', N'', N'', N'Quality Check', N'none', NULL, 1, NULL, NULL)
INSERT [dbo].[ForwardNoteMaster] ([Id], [batchId], [forwardingNoteNumber], [forwardNoteDate], [officerDesignation], [officerPostalAddress], [addressee], [nomenStore], [containerType], [sampleRefNumber], [sampleIdentificationMarks], [sampleQualtity], [numberOfSamples], [sampleType], [dispatchDate], [dispatchMethod], [sampleDrawnDate], [drawerNameAndRank], [quantityRepressntedBySample], [intendedDestination], [fillingDate], [iNoteNumber], [iNoteDate], [previousTestReferences], [tankNumber], [containerMarkingDetails], [tradeOwned], [govtStock], [tradeGovtAccepted], [reasonForTest], [governingSupply], [atNoReferences], [isForwardingNoteActive], [OldEslDate], [EslModifyDate]) VALUES (2, 7, N'FN02', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'Colonel', NULL, N'Quality Test centre Ambala', N'ATS Ambala', N'bottles', N'12342', N'none', CAST(15.000 AS Decimal(10, 3)), 1, N'aqvg composite', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'Car', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'Rohbit. Qa', CAST(15.000 AS Decimal(12, 3)), N'QTS Ambala', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'123', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'none', N't1111', N'not available', N'', N'yes', N'', N'Quality check ', N'NONE', NULL, 0, CAST(N'2016-01-29 00:00:00.000' AS DateTime), CAST(N'2016-06-28 06:53:02.953' AS DateTime))
INSERT [dbo].[ForwardNoteMaster] ([Id], [batchId], [forwardingNoteNumber], [forwardNoteDate], [officerDesignation], [officerPostalAddress], [addressee], [nomenStore], [containerType], [sampleRefNumber], [sampleIdentificationMarks], [sampleQualtity], [numberOfSamples], [sampleType], [dispatchDate], [dispatchMethod], [sampleDrawnDate], [drawerNameAndRank], [quantityRepressntedBySample], [intendedDestination], [fillingDate], [iNoteNumber], [iNoteDate], [previousTestReferences], [tankNumber], [containerMarkingDetails], [tradeOwned], [govtStock], [tradeGovtAccepted], [reasonForTest], [governingSupply], [atNoReferences], [isForwardingNoteActive], [OldEslDate], [EslModifyDate]) VALUES (5, 7, N'FN03', CAST(N'2016-06-26 00:00:00.000' AS DateTime), N'Driver', NULL, N'QTS CHD', N'QTS CHD', N'Container 10Ltrs', N'None', N'None', CAST(10.000 AS Decimal(10, 3)), 2, N'Normal', CAST(N'2016-06-26 00:00:00.000' AS DateTime), N'Bus to ISBT43', CAST(N'2016-06-26 00:00:00.000' AS DateTime), N'Rohit, QTS', CAST(20.000 AS Decimal(12, 3)), N'QTS CHD', CAST(N'2016-06-25 00:00:00.000' AS DateTime), N'I23', CAST(N'2016-06-14 00:00:00.000' AS DateTime), N'None', N'Tank123', N'NA', N'', N'Yes', N'', N'Qulaity teszt only ', N'none eeccc', NULL, 0, NULL, NULL)
INSERT [dbo].[ForwardNoteMaster] ([Id], [batchId], [forwardingNoteNumber], [forwardNoteDate], [officerDesignation], [officerPostalAddress], [addressee], [nomenStore], [containerType], [sampleRefNumber], [sampleIdentificationMarks], [sampleQualtity], [numberOfSamples], [sampleType], [dispatchDate], [dispatchMethod], [sampleDrawnDate], [drawerNameAndRank], [quantityRepressntedBySample], [intendedDestination], [fillingDate], [iNoteNumber], [iNoteDate], [previousTestReferences], [tankNumber], [containerMarkingDetails], [tradeOwned], [govtStock], [tradeGovtAccepted], [reasonForTest], [governingSupply], [atNoReferences], [isForwardingNoteActive], [OldEslDate], [EslModifyDate]) VALUES (8, 8, N'FN17Aug16', CAST(N'2016-08-17 00:00:00.000' AS DateTime), N'adaddsad', NULL, N'dsadaddsadsad', N'dsadasd', N'dsadsad', N'123', N'2313', CAST(1234.000 AS Decimal(10, 3)), 12, N'12', CAST(N'2016-08-17 00:00:00.000' AS DateTime), N'flight', CAST(N'2016-08-17 00:00:00.000' AS DateTime), N'weq 1213', CAST(111.000 AS Decimal(12, 3)), N'delhi', CAST(N'2016-08-18 00:00:00.000' AS DateTime), N'Inote123', CAST(N'2016-08-17 00:00:00.000' AS DateTime), N'2132131', N'eweq', N'weqweq', N'wewq', N'wewq', N'ewqeq', N'weqwe', N'weqwe', NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ForwardNoteMaster] OFF
SET IDENTITY_INSERT [dbo].[OriginalManufacture ] ON 

INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (1, N'om', N'mndsd', CAST(988322 AS Numeric(18, 0)), 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (2, N'om1', N'sjdls', CAST(998293827 AS Numeric(18, 0)), 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (3, N'kgh', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (4, N'wer', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (5, N's', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (6, N'd', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (7, N'a', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (8, N'Please type Original manufacture here', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (9, N'q', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (10, N'BARMA SIR', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (11, N'qw', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (12, N'assads', N'', NULL, 1)
INSERT [dbo].[OriginalManufacture ] ([Id], [Name], [Address], [ContactNo], [IsActivated]) VALUES (13, N'12', N'', NULL, 1)
SET IDENTITY_INSERT [dbo].[OriginalManufacture ] OFF
SET IDENTITY_INSERT [dbo].[PMandContainerMaster] ON 

INSERT [dbo].[PMandContainerMaster] ([Id], [MaterialName], [Capacity], [Grade], [Condition], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'container', N'25ltrs', N'a', N'sa', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PMandContainerMaster] OFF
SET IDENTITY_INSERT [dbo].[PMCapacity] ON 

INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (1, CAST(0 AS Numeric(18, 0)), N'  10000', CAST(N'2016-06-19 00:00:00.000' AS DateTime), CAST(N'2016-06-19 06:31:18.540' AS DateTime), 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (2, CAST(0 AS Numeric(18, 0)), N'50', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (3, CAST(0 AS Numeric(18, 0)), N'5000', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (4, CAST(0 AS Numeric(18, 0)), N'3000', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (5, CAST(0 AS Numeric(18, 0)), N'4500', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (6, CAST(0 AS Numeric(18, 0)), N'  7000', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (7, CAST(0 AS Numeric(18, 0)), N'  100', CAST(N'2016-06-24 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (8, CAST(0 AS Numeric(18, 0)), N'klm', CAST(N'2016-10-27 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (9, CAST(0 AS Numeric(18, 0)), N'j', CAST(N'2016-08-31 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (10, CAST(0 AS Numeric(18, 0)), N'do', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (11, CAST(0 AS Numeric(18, 0)), N'ij', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (12, CAST(0 AS Numeric(18, 0)), N'l,', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (13, CAST(0 AS Numeric(18, 0)), N'120 ltrs', CAST(N'2016-10-20 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (1008, CAST(0 AS Numeric(18, 0)), N'we', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (1009, CAST(0 AS Numeric(18, 0)), N'ok', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (2008, CAST(0 AS Numeric(18, 0)), N'  100 ltrs', CAST(N'2016-12-29 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (3008, CAST(0 AS Numeric(18, 0)), N'deq', CAST(N'2017-01-04 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (4008, CAST(0 AS Numeric(18, 0)), N'htf', CAST(N'2017-03-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (4009, CAST(0 AS Numeric(18, 0)), N'ytd', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCapacity] ([Id], [Capacity], [Unit], [AddedOn], [Modified], [IsActive]) VALUES (4010, CAST(0 AS Numeric(18, 0)), N'fse', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[PMCapacity] OFF
SET IDENTITY_INSERT [dbo].[PMCondition] ON 

INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1, N'sa', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2, N'SD', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3, N'FD', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4, N'AS', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (5, N'AQ', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (6, N'qw', CAST(N'2016-06-24 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (7, N'Good', CAST(N'2016-07-23 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (8, N'Great', CAST(N'2016-08-03 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (9, N'', CAST(N'2016-10-27 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (10, N'l', CAST(N'2016-08-31 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (11, N'q', CAST(N'2016-08-31 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (12, N'no', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (13, N'oij', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (14, N'lm', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (15, N'rs', CAST(N'2016-10-20 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1009, N'wed', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1010, N'k', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2009, N'tp', CAST(N'2016-12-29 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3009, N'qdq', CAST(N'2017-01-04 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4009, N'rtd', CAST(N'2017-03-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMCondition] ([Id], [Condition], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4010, N'YTF', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[PMCondition] OFF
SET IDENTITY_INSERT [dbo].[PMGrade] ON 

INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1, N'a', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2, N'F', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3, N'B', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4, N'C', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (5, N'm', CAST(N'2016-10-27 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (6, N'k', CAST(N'2016-08-29 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (7, N'ko', CAST(N'2016-08-30 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (8, N'wew', CAST(N'2016-08-30 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (9, N'er2', CAST(N'2016-08-30 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (10, N'q', CAST(N'2016-08-31 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (11, N'dwon', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (12, N'oij', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (13, N'l,', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1005, N'dew', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1006, N'ji', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2005, N'sa', CAST(N'2016-12-29 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3005, N'axxq', CAST(N'2017-01-04 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4005, N'56', CAST(N'2017-03-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMGrade] ([Id], [Grade], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4006, N'TRD', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[PMGrade] OFF
SET IDENTITY_INSERT [dbo].[PMNames] ON 

INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1, N'Material 1', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2, N'Box', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3, N'Oil', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (4, N'atta', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (5, N'Diesel', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (6, N'Boxes', CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (7, N'petrol', CAST(N'2016-06-21 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (8, N'Grease', CAST(N'2016-06-24 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (9, N'test material', CAST(N'2016-07-23 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (10, N'oko', CAST(N'2016-10-27 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (11, N'l,', CAST(N'2016-09-06 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1010, N'de', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (1011, N'ok', CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (2010, N'def', CAST(N'2017-01-04 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3010, N'brls', CAST(N'2017-03-19 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3011, N'JI', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[PMNames] ([Id], [Name], [AddedOn], [ModifiedOn], [IsActive]) VALUES (3012, N'sfe', CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[PMNames] OFF
SET IDENTITY_INSERT [dbo].[ProductMaster] ON 

INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (1, N'1', N'1', N'1', N'1', CAST(100 AS Decimal(18, 0)), NULL, 1, CAST(N'2016-02-14 16:54:47.593' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:20:33.800' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'916-000034', N'LTRS', CAST(1890 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (2, N'2', N'2', N'2', N'2', CAST(100 AS Decimal(18, 0)), N'PC-2', 3, CAST(N'2016-02-15 09:43:50.340' AS DateTime), NULL, NULL, 123, CAST(N'2016-03-05 09:24:26.940' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-0003818', N'LTRS', CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (3, N'3', N'3', N'3', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-3', 2, CAST(N'2016-02-15 09:46:20.997' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-15 21:33:50.737' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (4, N'4', N'4', N'4', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-4', 2, CAST(N'2016-02-15 09:50:00.190' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:09:59.480' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (5, N'5', N'5', N'5', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-5', 2, CAST(N'2016-02-15 09:50:54.027' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:10:07.663' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (6, N'6', N'6', N'6', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-6', 2, CAST(N'2016-02-15 09:51:59.813' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:10:16.470' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000099', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (7, N'7', N'7', N'7', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-7', 2, CAST(N'2016-02-15 09:53:05.650' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:10:25.303' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (8, N'8', N'8', N'8', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-8', 2, CAST(N'2016-02-15 09:54:06.203' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:10:36.980' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-006008', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (9, N'9', N'9', N'9', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-9', 2, CAST(N'2016-02-15 09:55:12.630' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:10:50.550' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-005523', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (28, N'14', N'14', N'14', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-28', 2, CAST(N'2016-02-15 10:18:22.883' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:15:27.340' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-0038180', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (30, N'15', N'15', N'15', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-30', 2, CAST(N'2016-02-15 10:20:00.330' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:16:09.390' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (31, N'16', N'16', N'16', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-31', 2, CAST(N'2016-02-15 10:21:26.000' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:16:19.470' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (32, N'11', N'11', N'11', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-32', 2, CAST(N'2016-02-15 10:22:44.220' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:16:44.300' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (39, N'12', N'12', N'12', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-39', 2, CAST(N'2016-02-15 10:28:10.290' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:17:51.987' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000169', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (43, N'w', N' Grease XG-274', N'Grease XG-274', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-43', 2, CAST(N'2016-02-15 10:30:41.527' AS DateTime), NULL, NULL, 123, CAST(N'2016-02-16 10:18:27.707' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-003923', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (54, N'WD-4 Preservation Fluid', N'WD-4 Preservation Fluid', N'WD-4 Preservation Fluid', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-54', 2, CAST(N'2016-02-16 19:47:46.097' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (55, N'Wood Lifting  Oil', N'Wood Lifting  Oil', N'Wood Lifting  Oil', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-55', 2, CAST(N'2016-02-16 19:49:19.450' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (56, N'Oil SAE-10 APECO', N'Oil SAE-10 APECO', N'Oil SAE-10 APECO', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-56', 2, CAST(N'2016-02-16 19:50:10.140' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (67, N'Servo -27', N'Servo -27', N'Servo -27', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-67', 2, CAST(N'2016-02-16 19:57:30.260' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (68, N'Sodium Phos Trrbins', N'Sodium Phos Trrbins', N'Sodium Phos Trrbins', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-68', 2, CAST(N'2016-02-16 19:58:30.323' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (69, N'Potassium Bloromat Tech', N'Potassium Bloromat Tech', N'Potassium Bloromat Tech', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-69', 2, CAST(N'2016-02-16 19:59:07.190' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (70, N'Sodium Nitrate Commrc', N'Sodium Nitrate Commrc', N'Sodium Nitrate Commrc', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-70', 2, CAST(N'2016-02-16 19:59:40.430' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (75, N'Servo Grease G-3', N'Servo Grease G-3', N'Servo Grease G-3', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-75', 2, CAST(N'2016-02-16 20:04:46.647' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (76, N'Oil Turbo', N'Oil Turbo', N'Oil Turbo', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-76', 2, CAST(N'2016-02-16 20:05:34.830' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (77, N'Servo Friz-46', N'Servo Friz-46', N'Servo Friz-46', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-77', 2, CAST(N'2016-02-16 20:06:06.517' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (78, N'Spl Brake Liquid CM-22', N'Spl Brake Liquid CM-22', N'Spl Brake Liquid CM-22', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-78', 2, CAST(N'2016-02-16 20:06:40.707' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (80, N'SAE 15 W 40', N'SAE 15 W 40', N'SAE 15 W 40', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-80', 2, CAST(N'2016-02-16 20:07:36.340' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (82, N'Oil Servo Quench No 11', N'Oil Servo Quench No 11', N'Oil Servo Quench No 11', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-82', 2, CAST(N'2016-02-16 20:08:50.670' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (83, N'Oil Servo Way H-57', N'Oil Servo Way H-57', N'Oil Servo Way H-57', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-83', 2, CAST(N'2016-02-16 20:09:25.753' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (84, N'SAE 75 W 90', N'SAE 75 W 90', N'SAE 75 W 90', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-84', 2, CAST(N'2016-02-16 20:10:00.240' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (85, N'Oil Servo Cut 945 ', N'Oil Servo Cut 945', N'Oil Servo Cut 945', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-85', 2, CAST(N'2016-02-16 20:11:00.793' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (87, N'Self Adhensive', N'Self Adhensive', N'Self Adhensive', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-87', 2, CAST(N'2016-02-16 20:12:36.673' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (89, N'Tape', N'Tape', N'Tape', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-89', 2, CAST(N'2016-02-16 20:13:59.053' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (95, N'WHL-H 832/A or Air-3520', N'WHL-H 832/A or Air-3520', N'WHL-H 832/A or Air-3520', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-95', 2, CAST(N'2016-02-16 20:19:02.550' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (103, N'PX-4/Air/8131/Def-2331', N'PX-4/Air/8131/Def-2331', N'PX-4/Air/8131/Def-2331', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-103', 2, CAST(N'2016-02-16 20:23:29.860' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (105, N'Super Oil Servo', N'Super Oil Servo', N'Super Oil Servo', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-105', 2, CAST(N'2016-02-16 20:24:19.493' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (106, N'Shell Turbo 27', N'Shell Turbo 27', N'Shell Turbo 27', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-106', 2, CAST(N'2016-02-16 20:24:48.260' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (111, N'Servo Gen EP-2', N'Servo Gen EP-2', N'Servo Gen EP-2', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-111', 2, CAST(N'2016-02-16 20:35:01.130' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (112, N'Oil SAE 15 W 40 (Multi Grade)', N'Oil SAE 15 W 40 (Multi Grade)', N'Oil SAE 15 W 40 (Multi Grade)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-112', 2, CAST(N'2016-02-16 20:36:55.070' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (113, N'Oil OT H2', N'Oil OT H2', N'Oil OT H2', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-113', 2, CAST(N'2016-02-16 20:37:43.137' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (114, N'Oil Servo Spin No 2', N'Oil Servo Spin No 2', N'Oil Servo Spin No 2', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-114', 2, CAST(N'2016-02-16 20:40:02.043' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (115, N'Oil Servo Sys No 57', N'Oil Servo Sys No 57', N'Oil Servo Sys No 57', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-115', 2, CAST(N'2016-02-16 20:40:43.720' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (116, N'Oil Tract ELF SF-31', N'Oil Tract ELF SF-31', N'Oil Tract ELF SF-31', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-116', 2, CAST(N'2016-02-16 20:43:46.097' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (117, N'Ord Oil', N'Ord Oil', N'Ord Oil', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-117', 2, CAST(N'2016-02-16 20:44:18.840' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (118, N'OX-27 (MIL-PRF-22699F)', N'OX-27 (MIL-PRF-22699F)', N'OX-27 (MIL-PRF-22699F)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-118', 2, CAST(N'2016-02-16 20:45:49.377' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'34B/2209940', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (119, N'Paste Silicon', N'Paste Silicon', N'Paste Silicon', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-119', 2, CAST(N'2016-02-16 20:46:14.790' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (120, N'Preservation Fluid ( Mil 6529 )', N'Preservation Fluid ( Mil 6529 )', N'Preservation Fluid ( Mil 6529 )', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-120', 2, CAST(N'2016-02-16 20:47:38.440' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (121, N'Rustillo DW X030/Braycote 151/ML-C-16173', N'Rustillo DW X030/Braycote 151/ML-C-16173', N'Rustillo DW X030/Braycote 151/ML-C-16173', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-121', 2, CAST(N'2016-02-16 22:34:50.093' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'ML-C-16173', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (131, N'SAE 75 W', N'SAE 75 W', N'SAE 75 W', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-131', 2, CAST(N'2016-02-19 09:42:10.487' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (132, N'SAE Multi Purpose Gr With Extreme Pressure', N'SAE Multi Purpose Gr With Extreme Pressure', N'SAE Multi Purpose Gr With Extreme Pressure', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-132', 2, CAST(N'2016-02-19 09:44:00.520' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (133, N'SAE 90 ', N'SAE 90 ', N'SAE 90 ', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-133', 2, CAST(N'2016-02-19 09:44:31.060' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (134, N'SAFCI RUBBRIC XP 22Z MOTUL', N'SAFCI RUBBRIC XP 22Z MOTUL', N'SAFCI RUBBRIC XP 22Z MOTUL', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-134', 2, CAST(N'2016-02-19 09:45:31.317' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (135, N'Servo Press 100', N'Servo Press 100', N'Servo Press 100', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-135', 2, CAST(N'2016-02-19 09:46:02.027' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (136, N'Servo Gear Super 90', N'Servo Gear Super 90', N'Servo Gear Super 90', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-136', 2, CAST(N'2016-02-19 09:46:35.153' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (137, N'Servo Oil', N'Servo Oil', N'Servo Oil', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-137', 2, CAST(N'2016-02-19 09:47:03.747' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (138, N'Servo Super -40', N'Servo Super -10 (OMD-40)', N'Servo Super -10 (OMD-40)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-138', 2, CAST(N'2016-02-19 09:47:51.590' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (139, N'Servo Super 90 or 80', N'Servo Super 90 or 80', N'Servo Super 90 or 80', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-139', 2, CAST(N'2016-02-19 09:48:20.270' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (140, N'Servo Super Grease-90', N'Servo Super Grease-90', N'Servo Super Grease-90', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-140', 2, CAST(N'2016-02-19 09:48:48.840' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (141, N'Servo System 12', N'Servo System 12', N'Servo System 12', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-141', 2, CAST(N'2016-02-19 09:49:26.887' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (142, N'Servo System 220', N'Servo System 220', N'Servo System 220', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-142', 2, CAST(N'2016-02-19 09:50:00.263' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (143, N'Servo System 32', N'Servo System 32', N'Servo System 32', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-143', 2, CAST(N'2016-02-19 09:50:37.603' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-003951', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (144, N'Servo System -68', N'Servo System -68', N'Servo System -68', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-144', 2, CAST(N'2016-02-19 09:55:22.780' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (145, N'Servo Ultra-10', N'Servo Ultra-10', N'Servo Ultra-10', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-145', 2, CAST(N'2016-02-19 09:55:53.933' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'ATO', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (146, N'Servo Ultrs-10', N'Servo Ultrs-10', N'Servo Ultrs-10', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-146', 2, CAST(N'2016-02-19 09:56:21.477' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'HEO', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (147, N'Servo Ultrs -10W', N'Servo Ultrs -10W', N'Servo Ultrs -10W', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-147', 2, CAST(N'2016-02-19 09:57:05.563' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (148, N'Servo Ultra Hylubes 03', N'Servo Ultra Hylubes 03', N'Servo Ultra Hylubes 03', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-148', 2, CAST(N'2016-02-19 09:57:48.837' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (149, N'Servo Ultrs KB-10', N'Servo Ultrs KB-10', N'Servo Ultrs KB-10', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-149', 2, CAST(N'2016-02-19 09:58:28.450' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (150, N'Shell-O-Grease', N'Shell-O-Grease (GEM-EPO)', N'Shell-O-Grease (GEM-EPO)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-150', 2, CAST(N'2016-02-19 09:59:10.910' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NK', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (151, N'Silicon Grease', N'Silicon Grease', N'Silicon Grease', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-151', 2, CAST(N'2016-02-19 09:59:47.163' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (152, N'Solvent Dry and Degreasing', N'Solvent Dry and Degreasing', N'Solvent Dry and Degreasing', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-152', 2, CAST(N'2016-02-19 10:00:38.777' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (153, N'Solvent Dry Cleaning', N'Solvent Dry Cleaning (Mineral Turpentine Oil)', N'Solvent Dry Cleaning (Mineral Turpentine Oil)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-153', 2, CAST(N'2016-02-19 10:01:49.453' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (154, N'WD 40 Anti Rust', N'WD 40 Anti Rust', N'WD 40 Anti Rust', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-154', 2, CAST(N'2016-02-19 10:06:44.817' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'31A/WD40', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (155, N'Oil OX-320', N'Oil OX-320', N'Oil OX-320', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-155', 2, CAST(N'2016-02-19 10:08:48.607' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000069', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (156, N'Oil Preservative SAE-30', N'Oil Preservative SAE-30', N'Oil Preservative SAE-30', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-156', 2, CAST(N'2016-02-19 10:12:31.540' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000073', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (157, N'Oil Spindle AU', N'Oil Spindle AU', N'Oil Spindle AU', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-157', 2, CAST(N'2016-02-19 10:13:11.770' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000126', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (158, N'Oil Watch', N'Oil Watch', N'Oil Watch', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-158', 2, CAST(N'2016-02-19 10:13:43.377' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000071', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (159, N'Oil OX-22-24', N'Oil OX-22-24', N'Oil OX-22-24', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-159', 2, CAST(N'2016-02-19 10:14:52.320' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (161, N'ZX-1', N'Oil Cutting ZX1', N'Oil Cutting ZX-1', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-161', 2, CAST(N'2016-02-19 10:18:06.887' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000032', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (162, N'Oil ZX-6', N'Oil ZX-6', N'Oil ZX-6', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-162', 2, CAST(N'2016-02-19 10:18:41.470' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000034', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (163, N'PES-3', N'Poly Ethylene Saloxena PES-3', N'Poly Ethylene Saloxena PES-3', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-163', 2, CAST(N'2016-02-19 10:19:25.910' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (164, N'Protective PX-1', N'Protective PX-1', N'Protective PX-1', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-164', 2, CAST(N'2016-02-19 10:20:03.560' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000003', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (165, N'Protective PX-2', N'Protective PX-2', N'Protective PX-2', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-165', 2, CAST(N'2016-02-19 10:21:03.970' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'0', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (166, N'Protective PX-6', N'Protective PX-6', N'Protective PX-6', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-166', 2, CAST(N'2016-02-19 10:26:13.980' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000004', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (167, N'Protective PX-7', N'Protective PX-7', N'Protective PX-7', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-167', 2, CAST(N'2016-02-19 10:29:06.787' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000007', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (168, N'Protective PX-10', N'Protective PX-10', N'Protective PX-10', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-168', 2, CAST(N'2016-02-19 10:29:51.917' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000008', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (169, N'Protective PX-11', N'Protective PX-11', N'Protective PX-11', N'0', CAST(100 AS Decimal(18, 0)), N'PC-169', 2, CAST(N'2016-02-19 10:30:44.650' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000009', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (170, N'Protective PX-12', N'Protective PX-12', N'Protective PX-12', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-170', 2, CAST(N'2016-02-19 10:31:16.840' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000009', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (171, N'Protective PX-15', N'Protective PX-15', N'Protective PX-15', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-171', 2, CAST(N'2016-02-19 10:32:25.723' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000001', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (172, N'Protective PX-24', N'Protective PX-24', N'Protective PX-24', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-172', 2, CAST(N'2016-02-19 10:32:55.020' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8060-000037', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (173, N'Servovoat 120', N'Servovoat 120', N'Servovoat 120', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-173', 2, CAST(N'2016-02-19 10:33:27.207' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (174, N'Servo Hydrex-32', N'Servo Hydrex-32', N'Servo Hydrex-32', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-174', 2, CAST(N'2016-02-19 10:34:15.730' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (175, N'Servo Prime 32', N'Servo Prime 32', N'Servo Prime 32', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-175', 2, CAST(N'2016-02-19 10:45:04.063' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9160-000033', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (176, N'Oil Turbine 32', N'Oil Turbine 32', N'Oil Turbine 32', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-176', 2, CAST(N'2016-02-19 10:45:33.717' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (178, N'Silicon Compound Dow', N'Silicon Compound Dow', N'Silicon Compound Dow', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-178', 2, CAST(N'2016-02-19 10:46:29.537' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (179, N'Solution Rust Removing', N'Solution Rust Removing', N'Solution Rust Removing', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-179', 2, CAST(N'2016-02-19 10:47:08.797' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'8030-000015', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (180, N'Transmission Fluid ''A''', N'Transmission Fluid ''A''', N'Transmission Fluid ''A''', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-180', 2, CAST(N'2016-02-19 10:47:50.747' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-003956', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (181, N'Transmission Fluyid F-10', N'Transmission Fluyid F-10', N'Transmission Fluyid F-10', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-181', 2, CAST(N'2016-02-19 10:48:21.577' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (182, N'Transmission Fluid T-20', N'Transmission Fluid T-20', N'Transmission Fluid T-20', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-182', 2, CAST(N'2016-02-19 10:49:04.547' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-003984', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (183, N'URF Plain', N'URF Plain', N'URF Plain', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-183', 2, CAST(N'2016-02-19 10:50:07.433' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'6850-003890', N'LTRS', CAST(0 AS Numeric(18, 0)))
GO
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (184, N'URF 75 : 25', N'URF 75 : 25', N'URF 75 : 25', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-184', 2, CAST(N'2016-02-19 10:50:44.523' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'6850-000111', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (185, N'URF 80 : 20', N'URF 80 : 20', N'URF 80 : 20', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-185', 2, CAST(N'2016-02-19 10:51:14.620' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'6850-000110', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (186, N'Warm Grease', N'Warm Grease', N'Warm Grease', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-186', 2, CAST(N'2016-02-19 10:51:42.233' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-004551', N'KG', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (189, N'Water Detection Capsules', N'Water Detection Capsules', N'Water Detection Capsules', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-189', 2, CAST(N'2016-02-19 10:54:47.827' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'PCS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (207, N'OMHB', N'Oil Mineral Hydraulic Buffer', N'OMHB', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-207', 2, CAST(N'2016-02-19 11:07:11.293' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000141', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (214, N'Oil OM-58', N'Oil OM-58', N'Oil OM-58', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-214', 2, CAST(N'2016-02-19 11:10:47.147' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000027', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (215, N'Oil OM-65', N'Oil OM-65', N'Oil OM-65', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-215', 2, CAST(N'2016-02-19 11:11:36.550' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000028', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (217, N'Oil OXB-4', N'Oil OXB-4', N'Oil OXB-4', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-217', 2, CAST(N'2016-02-19 11:12:38.227' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-003906', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (218, N'Oil OX-13', N'Oil OX-13', N'Oil OX-13', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-218', 2, CAST(N'2016-02-19 11:13:11.803' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000066', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (219, N'Oil OX-52', N'Oil OX-52', N'Oil OX-52', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-219', 2, CAST(N'2016-02-19 11:13:36.640' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'9150-000068', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (220, N'Aqua Indica Water Finding Paste', N'Aqua Indica Water Finding Paste', N'Aqua Indica Water Finding Paste', N'Use for QC of ATF', CAST(100 AS Decimal(18, 0)), N'PC-220', 2, CAST(N'2016-02-19 11:15:29.800' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'PCS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (271, N'SKO', N'Kero Superior Oil', N'Kerosine', N'na', CAST(100 AS Decimal(18, 0)), N'PC-271', 6, CAST(N'2016-03-02 10:42:29.077' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(50000 AS Numeric(18, 0)), N'Pending', N'NK', N'LTRS', CAST(78000 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (282, N'Pyrethrum Extract 2%', N'Pyrethrum Extract 2%', N'Pyrethrum Extract 2%', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-282', 3, CAST(N'2016-03-04 10:57:06.160' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (284, N'Temphose 50%( Abat C)', N'Temphose 50%( Abat C)', N'Temphose 50%( Abat C)', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-284', 3, CAST(N'2016-03-04 10:59:57.530' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (286, N'Propoxure 20% EC', N'Propoxure 20% EC', N'Propoxure 20% EC', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-286', 3, CAST(N'2016-03-04 11:04:12.720' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (297, N'13', N'13', N'13', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-297', 3, CAST(N'2016-03-05 09:19:25.250' AS DateTime), NULL, NULL, 123, CAST(N'2016-03-10 22:53:12.393' AS DateTime), 0, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'LTRS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (300, N'Vitamin '' C'' Tabs', N'Vitamin  ''C'' Tabs', N'Vitamin  ''C'' Tabs', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-300', 3, CAST(N'2016-03-05 09:22:27.877' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'NOS', CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[ProductMaster] ([Product_ID], [Product_Name], [Product_Desc], [Short_Product_Desc], [Admin_Remarks], [product_cost], [Product_Code], [Category_Id], [AddedOn], [MfgDate], [ExpDate], [AddedBy], [ModifiedOn], [ModifiedBy], [IsActive], [StockQty], [IsProductStatus], [Cat], [productUnit], [GSreservre]) VALUES (301, N'Poly Vitamin Tabs', N'Poly Vitamin Tabs', N'Poly Vitamin Tabs', N'NA', CAST(100 AS Decimal(18, 0)), N'PC-301', 3, CAST(N'2016-03-05 09:23:26.177' AS DateTime), NULL, NULL, 123, NULL, NULL, 1, CAST(0 AS Numeric(18, 0)), N'Pending', N'NIV', N'NOS', CAST(0 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[ProductMaster] OFF
SET IDENTITY_INSERT [dbo].[RoleMaster] ON 

INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (1, N'1', N'1', N'1', 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (15, N'RC-1', N' Manage Adminstration Work', N' Manage Adminstration Work', 1, CAST(N'2015-02-06 14:08:28.357' AS DateTime), NULL, CAST(N'2015-02-06 14:10:37.207' AS DateTime), 786, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (16, N'RC-16', N'Manage admin', N'Manage admin', 1, CAST(N'2015-02-06 14:10:08.740' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (17, N'RC-17', N'ADMIN', N'ADMIN', 1, CAST(N'2015-02-06 14:15:11.857' AS DateTime), NULL, CAST(N'2015-03-30 01:32:12.450' AS DateTime), 786, 11, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (19, N'RC-19', N'Admin', N'Test', 1, CAST(N'2015-03-25 23:08:34.410' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (20, N'RC-20', N'ST9 CLERK', N'ST Clerk', 1, CAST(N'2015-03-25 23:11:09.273' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (21, N'RC-21', N'RECEIPT AND DISPATCH', N'Receipt and Dispatch', 1, CAST(N'2015-03-25 23:11:31.020' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (22, N'RC-22', N'GROUP HOLDER', N'Group holder', 1, CAST(N'2015-03-25 23:12:02.157' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (23, N'RC-23', N'GATEMAN', N'Gateman', 1, CAST(N'2015-03-25 23:12:24.923' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (24, N'RC-24', N'INDENT OFFICER', N'Indent officer', 1, CAST(N'2015-03-25 23:12:43.577' AS DateTime), NULL, NULL, NULL, 10, 1)
INSERT [dbo].[RoleMaster] ([Role_ID], [Role_Code], [Role], [Role_Desc], [IsActive], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [DeptId], [Rank]) VALUES (25, N'RC-25', N'SUPER ADMIN', N'SUPER ADMIN', 1, CAST(N'2015-03-30 01:34:32.310' AS DateTime), NULL, CAST(N'2015-03-30 01:34:43.337' AS DateTime), 786, 10, 1)
SET IDENTITY_INSERT [dbo].[RoleMaster] OFF
SET IDENTITY_INSERT [dbo].[StockMaster] ON 

INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (1, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, NULL, 0, NULL, CAST(N'2016-06-19 06:03:27.530' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'received', NULL, NULL, NULL, N'Material 1', NULL, N'AT1', N'Central Procurement', N'AK Agencies', N'None', NULL, NULL, 2, 0, N'Sphere', N'20', 2, N'1X10', NULL, NULL, CAST(5.000 AS Decimal(18, 3)), N'KGS', N'cm', 1, 1, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (2, CAST(9920.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 06:59:12.167' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'received', NULL, NULL, NULL, N'Material 1', NULL, N'AT1', N'Central Procurement', N'AK Agencies', N'None', NULL, NULL, 2, 0, N'Sphere', N'10', 2, N'1X10', N'CRV1', NULL, CAST(5.000 AS Decimal(18, 3)), N'KGS', N'cm', 1, 1, 2, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (3, CAST(4940.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 07:11:32.100' AS DateTime), 1, NULL, NULL, CAST(-800.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'received', NULL, NULL, NULL, N'Oil', NULL, N'AT2', N'Central Procurement', N'ALKLY AMINE CHEMICAL LTD', N'None', NULL, NULL, 297, 0, N'Cube', N'20', 3, N'1X10X10', N'CRV2', NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 3, 3, 1, 0, 0, 1, 0, N'Box', 2, 2, 3, N'Cube', N'2', CAST(10.000 AS Decimal(18, 3)), N'GRAMS', N'cm', CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (4, CAST(3000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 07:16:50.487' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'qw', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'received', NULL, NULL, NULL, N'atta', NULL, N'AT3', N'Central Procurement', N'kumar nath', N'None', NULL, NULL, 3, 0, N'Sphere', N'2', 2, N'1X5', N'CRV3', NULL, CAST(10.000 AS Decimal(18, 3)), N'KGS', N'ft', 1, 4, 4, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (5, CAST(4420.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 07:21:43.197' AS DateTime), 1, NULL, NULL, CAST(400.000 AS Decimal(18, 3)), NULL, NULL, N'kgh', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'rec', NULL, NULL, NULL, N'Diesel', NULL, N'AT4', N'Central Procurement', N'Bombay Chem Pvt Ltd', N'None', NULL, NULL, 28, 0, N'Sphere', N'15', 0, NULL, N'CRV4', NULL, CAST(30.000 AS Decimal(18, 3)), N'KGS', N'cm', 3, 5, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (6, CAST(1400.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 07:27:56.263' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'wer', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, N'AT5', N'Central Procurement', N'Gulf Oil Ltd', N'None', NULL, NULL, 30, 0, N'', NULL, 0, N'', N'CRV5', NULL, CAST(500.000 AS Decimal(18, 3)), N'TONNES', N'cm', NULL, NULL, NULL, 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (7, CAST(7000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-19 07:32:21.713' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'om', NULL, CAST(N'2016-06-19 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'Boxes', NULL, N'AT6', N'Central Procurement', N'Kusum Ind Pvt Ltd', N'None', NULL, NULL, 31, 0, N'Cube', N'15', 0, N'', N'CRV6', NULL, CAST(250.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 4, 6, 5, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (8, CAST(2100.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-21 19:05:25.527' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-06-21 00:00:00.000' AS DateTime), NULL, NULL, N'received', NULL, NULL, NULL, N'petrol', NULL, N'AT7', N'Central Procurement', N'CI Laboratries', N'None', NULL, NULL, 3, 0, N'Cylinder', N'10X150', 2, N'1X50', N'CRV1', NULL, CAST(50.000 AS Decimal(18, 3)), N'KGS', N'cm', NULL, 1, NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (9, CAST(8790.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-06-24 23:19:49.600' AS DateTime), 1, NULL, NULL, CAST(1400.000 AS Decimal(18, 3)), NULL, NULL, N'wer', NULL, CAST(N'2016-06-24 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'Grease', NULL, N'AT123845', N'Central Procurement', N'Cogent', N'None', NULL, NULL, 39, 0, N'Cube', N'30', 2, N'1X10', N'CRV1 24/06/2016', NULL, CAST(10.000 AS Decimal(18, 3)), N'KGS', N'cm', 1, 7, 6, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (10, CAST(28000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-07-23 17:01:07.827' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'kgh', NULL, CAST(N'2016-07-23 00:00:00.000' AS DateTime), NULL, NULL, N'stock in test', NULL, NULL, NULL, N'test material', NULL, N'23/07/16', N'Central Procurement', N'FPD ASC Leh', N'None', NULL, NULL, 3, 0, N'Cube', N'15', 2, N'1X20', NULL, NULL, CAST(10.000 AS Decimal(18, 3)), N'KGS', N'ft', 1, 1, 7, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (11, CAST(14850.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-08-03 22:14:18.397' AS DateTime), 1, NULL, NULL, CAST(2840.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-08-03 00:00:00.000' AS DateTime), NULL, NULL, N'Stock Received', NULL, NULL, NULL, N'Box', NULL, N'AT_N_12345', N'Central Procurement', N'Baroda Pharmacuitecals Ltd', N'None', NULL, NULL, 32, 0, N'Cube', N'1', 2, N'1X10', N'CRV_03AUG2016', NULL, CAST(100.000 AS Decimal(18, 3)), N'KGS', N'ft', 1, 1, 8, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (12, CAST(5000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-08-17 21:51:46.357' AS DateTime), 1, NULL, NULL, CAST(700.000 AS Decimal(18, 3)), NULL, NULL, N'kgh', NULL, CAST(N'2016-08-17 00:00:00.000' AS DateTime), NULL, NULL, N'new stock received', NULL, NULL, NULL, NULL, NULL, N'At17Aug16', N'Central Procurement', N'Cogent', N'IDT', NULL, NULL, 32, 0, N'', NULL, 0, N'', N'CRV17Aug16', NULL, CAST(10.000 AS Decimal(18, 3)), N'GRAMS', N'cm', NULL, NULL, NULL, 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (13, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-08-17 22:36:23.963' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'assads', NULL, CAST(N'2016-08-17 00:00:00.000' AS DateTime), NULL, NULL, N'adasd', NULL, NULL, NULL, NULL, NULL, N'21323ada', N'Central Procurement', N'Alkyl Amines Chem Ltd', N'None', NULL, NULL, 220, 0, N'', NULL, 0, N'', NULL, NULL, CAST(12.000 AS Decimal(18, 3)), N'GRAMS', N'cm', NULL, NULL, NULL, 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (14, CAST(1000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-10-27 10:58:55.243' AS DateTime), 1, NULL, NULL, CAST(1800.000 AS Decimal(18, 3)), NULL, NULL, N'kgh', NULL, CAST(N'2016-10-27 00:00:00.000' AS DateTime), NULL, NULL, N'u', NULL, NULL, NULL, N'oko', NULL, N'new', N'Central Procurement', N'Alkyl Amines Chem Ltd', N'None', NULL, NULL, 30, 0, N'Cube', N'2', 0, NULL, N'testnew', NULL, CAST(21.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 5, 8, 9, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (1014, CAST(1000.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-11-05 10:05:13.910' AS DateTime), 1, NULL, NULL, CAST(1250.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-11-21 00:00:00.000' AS DateTime), NULL, NULL, N'e', NULL, NULL, NULL, N'de', NULL, N'hi', N'Central Procurement', N'hello', N'None', NULL, NULL, 1, 0, N'Sphere', N'1', 2, N'1X10', N'loveleet koti 1', NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 1005, 1008, 1009, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (1015, CAST(1500.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-11-05 10:08:55.590' AS DateTime), 1, CAST(N'2016-11-05 10:09:37.403' AS DateTime), 1, CAST(1150.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-11-09 00:00:00.000' AS DateTime), NULL, NULL, N'e', NULL, NULL, NULL, N'de', NULL, N'hi', N'Central Procurement', N'hello', N'None', NULL, NULL, 1, 0, N'Sphere', N'1', 2, N'1X10', N'loveleet koti 2', NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 1006, 1009, 1010, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (2014, CAST(600.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2016-12-29 00:50:17.247' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2016-12-29 00:00:00.000' AS DateTime), NULL, NULL, N'ajbb', NULL, NULL, NULL, N'Boxes', NULL, N'kjhg', N'Central Procurement', N'Coromandel International Ltd', N'None', NULL, NULL, 119, 0, N'Cylinder', N'12X2', 2, N'1X10', NULL, NULL, CAST(120.000 AS Decimal(18, 3)), N'KGS', N'cm', 2005, 2008, 2009, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (3014, CAST(1200.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2017-01-04 20:32:09.473' AS DateTime), 1, CAST(N'2017-01-04 20:35:11.613' AS DateTime), 1, CAST(212.000 AS Decimal(18, 3)), NULL, NULL, N'assads', NULL, CAST(N'2017-01-04 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'def', NULL, N'AT_N_12345', N'Central Procurement', N'M/S S B Eqipments Karol Bag', N'None', NULL, NULL, 116, 0, N'Cube', N'2', 2, N'1X12', N'loveleey testing 4 jan', NULL, CAST(120.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 3005, 3008, 3009, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (4014, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2017-03-19 17:56:22.233' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2017-03-19 00:00:00.000' AS DateTime), NULL, NULL, N'g', NULL, NULL, NULL, N'brls', NULL, N'vipan', N'Central Procurement', N'ALKLY AMINE CHEMICAL LTD', N'None', NULL, NULL, 83, 0, N'Sphere', N'', 2, N'1X10', NULL, NULL, CAST(210.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 4005, 4008, 4009, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (4015, CAST(2400.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2017-03-20 19:53:47.950' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'JI', NULL, N'485', N'Central Procurement', N'Bombay Chem Pvt Ltd', N'None', NULL, NULL, 220, 0, N'Sphere', N'3', 2, N'1X10', NULL, NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 4006, 4009, 4010, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (4016, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2017-03-20 20:06:28.727' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'atta', NULL, N'aasda', N'Central Procurement', N'Baroda Pharmacuitecals Ltd', N'None', NULL, NULL, 112, 0, N'Sphere', N'2', 2, N'1X10', NULL, NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', NULL, 13, 4, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-01 00:00:00.000' AS DateTime))
INSERT [dbo].[StockMaster] ([SID], [Quantity], [MinQuantity], [QuantityType], [BID], [IsActive], [IsStockIn], [AddedOn], [AddedBy], [ModifiedOn], [ModifiedBy], [IssueQty], [SupplierId], [GenericName], [OriginalManf], [SentQty], [RecievedOn], [DriverName], [InterTransferId], [Remarks], [ChallanOrIrNo], [IsChallanNo], [IsIrNo], [PackingMaterial], [UnitInfo], [ATNo], [RecievedFrom], [OtherSupplier], [TransferedBy], [SampleSent], [ContactNo], [ProductId], [CostOfParticular], [PackagingMaterialShape], [PackagingMaterialSize], [PackagingMaterialFormatLevel], [PackingMaterialFormat], [CRVNo], [SupplierNo], [Weight], [WeigthUnit], [ShapeUnit], [PMGradeId], [PMCapacityId], [PMConditionId], [IsEmptyPM], [IsWithoutPacking], [IsSubPacking], [IsDW], [SubPMName], [SubPMGradeId], [SubPMCapacityId], [SubPMConditionId], [SubPMShape], [SubPMSize], [SubWeight], [SubWeightUnit], [SubShapeUnit], [Session]) VALUES (4017, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, NULL, 1, NULL, CAST(N'2017-03-20 21:59:12.407' AS DateTime), 1, NULL, NULL, CAST(0.000 AS Decimal(18, 3)), NULL, NULL, N'BARMA SIR', NULL, CAST(N'2017-03-20 00:00:00.000' AS DateTime), NULL, NULL, N'', NULL, NULL, NULL, N'sfe', NULL, N'sdf', N'Central Procurement', N'AVI Oils', N'None', NULL, NULL, 112, 0, N'Sphere', N'-2', 2, N'1X10', NULL, NULL, CAST(100.000 AS Decimal(18, 3)), N'GRAMS', N'cm', 2, 4010, 3, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2017-04-01 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[StockMaster] OFF
SET IDENTITY_INSERT [dbo].[StockPakaging] ON 

INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (1, N'Full', 1, CAST(5500.000 AS Decimal(18, 3)), N'550X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (2, N'Full', 2, CAST(3700.000 AS Decimal(18, 3)), N'370X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (3, N'Loose', 1, CAST(450.000 AS Decimal(18, 3)), N'5|450')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (4, N'Loose', 2, CAST(270.000 AS Decimal(18, 3)), N'3|270')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (5, N'Full', 3, CAST(4900.000 AS Decimal(18, 3)), N'49X10X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (6, N'Loose', 3, CAST(40.000 AS Decimal(18, 3)), N'1|6|40')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (7, N'Full', 4, CAST(3000.000 AS Decimal(18, 3)), N'600X5')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (8, N'DW', 5, CAST(4420.000 AS Decimal(18, 3)), N'90XDW')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (9, N'Full', 8, CAST(1000.000 AS Decimal(18, 3)), N'20X50')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (10, N'Full', 9, CAST(1100.000 AS Decimal(18, 3)), N'22X50')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (11, N'Full', 10, CAST(4900.000 AS Decimal(18, 3)), N'490X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (12, N'Full', 11, CAST(3860.000 AS Decimal(18, 3)), N'386X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (13, N'Loose', 10, CAST(10.000 AS Decimal(18, 3)), N'2|10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (14, N'Loose', 11, CAST(20.000 AS Decimal(18, 3)), N'5|20')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (15, N'Full', 15, CAST(1200.000 AS Decimal(18, 3)), N'24X10X5')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (16, N'Loose', 14, CAST(34.000 AS Decimal(18, 3)), N'2|1|34')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (17, N'Loose', 15, CAST(34.000 AS Decimal(18, 3)), N'2|1|34')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (18, N'Full', 16, CAST(2000.000 AS Decimal(18, 3)), N'200X2X5')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (19, N'Full', 17, CAST(1000.000 AS Decimal(18, 3)), N'100X2X5')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (20, N'Full', 18, CAST(2040.000 AS Decimal(18, 3)), N'17X12X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (21, N'Full', 15, CAST(9850.000 AS Decimal(18, 3)), N'985X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (22, N'Full', 16, CAST(4850.000 AS Decimal(18, 3)), N'485X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (23, N'Loose', 15, CAST(50.000 AS Decimal(18, 3)), N'90|50')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (24, N'Loose', 16, CAST(100.000 AS Decimal(18, 3)), N'40|100')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (25, N'DW', 18, CAST(1000.000 AS Decimal(18, 3)), N'32XDW')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (1025, N'Full', 1018, CAST(1000.000 AS Decimal(18, 3)), N'100X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (1026, N'Full', 1019, CAST(1500.000 AS Decimal(18, 3)), N'150X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (2025, N'Full', 2018, CAST(400.000 AS Decimal(18, 3)), N'40X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (2026, N'Full', 2019, CAST(200.000 AS Decimal(18, 3)), N'20X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (3025, N'Full', 3018, CAST(996.000 AS Decimal(18, 3)), N'83X12')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (3026, N'Full', 3019, CAST(192.000 AS Decimal(18, 3)), N'16X12')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (3027, N'Loose', 3018, CAST(4.000 AS Decimal(18, 3)), N'2|4')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (3028, N'Loose', 3019, CAST(8.000 AS Decimal(18, 3)), N'4|8')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (4025, N'Full', 4020, CAST(1500.000 AS Decimal(18, 3)), N'150X10')
INSERT [dbo].[StockPakaging] ([Id], [PackagingType], [StockBatchId], [RemainingQty], [Format]) VALUES (4026, N'Full', 4021, CAST(900.000 AS Decimal(18, 3)), N'90X10')
SET IDENTITY_INSERT [dbo].[StockPakaging] OFF
SET IDENTITY_INSERT [dbo].[StockSpillage] ON 

INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (1, 2, 1, CAST(50.000000000000000000 AS Decimal(36, 18)), CAST(50 AS Decimal(36, 0)), CAST(50 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2, 2, 2, CAST(30.000000000000000000 AS Decimal(36, 18)), CAST(30 AS Decimal(36, 0)), CAST(30 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (3, 3, 3, CAST(60.000000000000000000 AS Decimal(36, 18)), CAST(1 AS Decimal(36, 0)), CAST(1 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (4, 5, 5, CAST(80.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (5, 6, 11, CAST(0.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (6, 6, 6, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (7, 7, 7, CAST(0.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (8, 9, 10, CAST(90.000000000000000000 AS Decimal(36, 18)), CAST(10 AS Decimal(36, 0)), CAST(9 AS Decimal(36, 0)), CAST(5 AS Decimal(36, 0)), CAST(1 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (9, 9, 11, CAST(120.000000000000000000 AS Decimal(36, 18)), CAST(14 AS Decimal(36, 0)), CAST(12 AS Decimal(36, 0)), CAST(6 AS Decimal(36, 0)), CAST(2 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (13, 11, 15, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(15 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(1 AS Decimal(36, 0)), CAST(5 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (14, 11, 16, CAST(50.000000000000000000 AS Decimal(36, 18)), CAST(15 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(2 AS Decimal(36, 0)), CAST(5 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (15, 12, 17, CAST(0.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (16, 14, 18, CAST(0.000000000000000000 AS Decimal(36, 18)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (1016, 2014, 2018, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(10 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2016, 4014, 4018, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(50 AS Decimal(36, 0)), CAST(50 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2017, 4014, 4019, CAST(200.000000000000000000 AS Decimal(36, 18)), CAST(20 AS Decimal(36, 0)), CAST(20 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2018, 4015, 4020, CAST(500.000000000000000000 AS Decimal(36, 18)), CAST(50 AS Decimal(36, 0)), CAST(50 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2019, 4015, 4021, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(10 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2020, 4016, 4023, CAST(200.000000000000000000 AS Decimal(36, 18)), CAST(10 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
INSERT [dbo].[StockSpillage] ([Id], [StockId], [StockBatchId], [SpilledQty], [DamagedBoxes], [SpillageAffected], [SampleAffected], [BothAffected]) VALUES (2021, 4016, 4022, CAST(100.000000000000000000 AS Decimal(36, 18)), CAST(10 AS Decimal(36, 0)), CAST(10 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)), CAST(0 AS Decimal(36, 0)))
SET IDENTITY_INSERT [dbo].[StockSpillage] OFF
SET IDENTITY_INSERT [dbo].[StockVehicle] ON 

INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (1, 2, N'D16', N'V1', 1, CAST(6000.000 AS Decimal(18, 3)), CAST(5950.000 AS Decimal(18, 3)), N'1111', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (2, 2, N'D2', N'V2', 2, CAST(4000.000 AS Decimal(18, 3)), CAST(3970.000 AS Decimal(18, 3)), N'1222', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (3, 3, N'Dri1', N'Veh1', 3, CAST(5000.000 AS Decimal(18, 3)), CAST(4940.000 AS Decimal(18, 3)), N'1231', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4, 4, N'Briver', N'1231', 4, CAST(3000.000 AS Decimal(18, 3)), CAST(3000.000 AS Decimal(18, 3)), N'1212121', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (5, 5, N'Ram singh', N'12121', 5, CAST(4500.000 AS Decimal(18, 3)), CAST(4420.000 AS Decimal(18, 3)), N'111111', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (6, 6, N'Dri1', N've1', 6, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'1211', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (7, 6, N'Dri2', N've2', 6, CAST(500.000 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), N'1212', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (8, 7, N'Bri', N'car11', 7, CAST(7000.000 AS Decimal(18, 3)), CAST(7000.000 AS Decimal(18, 3)), N'114141', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (9, 8, N'Crib', N'vh1', 8, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'10001', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (10, 8, N'Crib', N'vh1', 9, CAST(1100.000 AS Decimal(18, 3)), CAST(1100.000 AS Decimal(18, 3)), N'10001', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (11, 9, N'Dri1', N'v1', 10, CAST(5000.000 AS Decimal(18, 3)), CAST(4910.000 AS Decimal(18, 3)), N'1234', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (12, 9, N'Dri2', N'v2', 11, CAST(4000.000 AS Decimal(18, 3)), CAST(3880.000 AS Decimal(18, 3)), N'1233', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (13, 10, N'Driver1', N'Vehicle1', 12, CAST(10000.000 AS Decimal(18, 3)), CAST(9500.000 AS Decimal(18, 3)), N'1234', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (14, 10, N'Driver1', N'Vehicle1', 13, CAST(11000.000 AS Decimal(18, 3)), CAST(10500.000 AS Decimal(18, 3)), N'1212', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (15, 10, N'Driver2', N'Vehicle2', 14, CAST(9000.000 AS Decimal(18, 3)), CAST(8000.000 AS Decimal(18, 3)), N'1122', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (16, 10, N'Driver2', N'Vehicle2', 12, CAST(5000.000 AS Decimal(18, 3)), CAST(4500.000 AS Decimal(18, 3)), N'1237', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (17, 11, N'Driver100', N'V100', 15, CAST(10000.000 AS Decimal(18, 3)), CAST(9900.000 AS Decimal(18, 3)), N'C100', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (18, 11, N'Driver100', N'V100', 16, CAST(5000.000 AS Decimal(18, 3)), CAST(4950.000 AS Decimal(18, 3)), N'C100', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (19, 12, N'D17Aug16', N'V17Aug16', 17, CAST(5000.000 AS Decimal(18, 3)), CAST(5000.000 AS Decimal(18, 3)), N'12345', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (20, 14, N'9', N'j', 18, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'9j', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (21, 13, N'hi', N'lkj9', 21, CAST(1003.000 AS Decimal(18, 3)), CAST(1003.000 AS Decimal(18, 3)), N'kh', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (1020, 1014, N'jai', N'ajai', 1018, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'iji', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (1021, 1015, N'jn', N'jn', 1019, CAST(1500.000 AS Decimal(18, 3)), CAST(1500.000 AS Decimal(18, 3)), N'jn', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (2020, 2014, N'koti', N'1234', 2018, CAST(1000.000 AS Decimal(18, 3)), CAST(900.000 AS Decimal(18, 3)), N'knllk', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (2021, 2014, N'koti', N'1234', 2019, CAST(200.000 AS Decimal(18, 3)), CAST(200.000 AS Decimal(18, 3)), N'knllk', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (2022, 2014, N'hiko', N'guig', 2018, CAST(400.000 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), N'uisgh', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (3020, 3014, N'jai', N'90j', 3018, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'0j09j', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (3021, 3014, N'jaie2', N'90je2', 3019, CAST(200.000 AS Decimal(18, 3)), CAST(200.000 AS Decimal(18, 3)), N'0j09j1', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4020, 4014, N'jio', N'5476', 4018, CAST(2000.000 AS Decimal(18, 3)), CAST(1500.000 AS Decimal(18, 3)), N'3ygy', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4021, 4014, N'jio', N'5476', 4019, CAST(300.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), N'3ygy', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4022, 4014, N'jioer', N'5476ger', 4018, CAST(200.000 AS Decimal(18, 3)), CAST(100.000 AS Decimal(18, 3)), N'3ygye', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4023, 4015, N'loveleet', N'jiii123', 4020, CAST(2000.000 AS Decimal(18, 3)), CAST(1500.000 AS Decimal(18, 3)), N'dji32', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4024, 4015, N'loveleet', N'jiii123', 4021, CAST(1000.000 AS Decimal(18, 3)), CAST(900.000 AS Decimal(18, 3)), N'dji32', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4025, 4016, N'hausodh', N'oijasdoi', 4023, CAST(1000.000 AS Decimal(18, 3)), CAST(1000.000 AS Decimal(18, 3)), N'oijo', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4028, 4016, N'qwer', N'qewqwe', 4023, CAST(1000.000 AS Decimal(18, 3)), CAST(800.000 AS Decimal(18, 3)), N'qwdq', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4029, 4017, N'tr', N'tert', 4024, CAST(2000.000 AS Decimal(18, 3)), CAST(1500.000 AS Decimal(18, 3)), N'ert', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4030, 4017, N'tr', N'tert', 4025, CAST(100.000 AS Decimal(18, 3)), CAST(80.000 AS Decimal(18, 3)), N'ert', N'CHT')
INSERT [dbo].[StockVehicle] ([Id], [StockID], [DriverName], [VehicleNo], [StockBatchId], [SentQty], [RecievedQty], [ChallanNo], [IsDDOrCHT]) VALUES (4031, 4017, N'ytuj', N'fgh', 4024, CAST(500.000 AS Decimal(18, 3)), CAST(400.000 AS Decimal(18, 3)), N'fh', N'CHT')
SET IDENTITY_INSERT [dbo].[StockVehicle] OFF
SET IDENTITY_INSERT [dbo].[supplier] ON 

INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (1, N'IOC', N'Mr Sudeep Tiwari
Marketing Manager', 1, CAST(9417217952 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (2, N'Balmer Lowries & Co', N'Mr Dev Mukherjee 
Marketing Manager', 1, CAST(987320457 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (3, N'Baroda Pharmacuitecals Ltd', N'Baroda Gujrat', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (4, N'SMK Petro Chem Pvt Ltd', N'Sonepat  Haryana', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (5, N'Alkyl Amines Chem Ltd', N'Pune Maharastra', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (6, N'Coromandel International Ltd', N'Secundrabad (AP)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (7, N'HPCL', N'Hindustan Petrochemicla Ltd Mumbai', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (8, N'BPCL', N'BPCL Mumbai', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (9, N'Bombay Chem Pvt Ltd', N'Patlipada Thane Mumbai', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (10, N'Gulf Oil Ltd', N'Selvassa (Div Daman)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (11, N'Tagros Chem India Ltd', N'Cuddalore (TN)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (12, N'Kusum Ind Pvt Ltd', N'Jaipur (Rajasthan)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (13, N'Shivai Petroluem ', N'Bahadurgarh Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (14, N'Gandhar Oil India Ltd', N'Selvassa', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (15, N'Cogent', N'Sonepat Haryana', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (16, N'Sreenath jee Chem', N'Raisen (MP)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (17, N'Sourya Solution', N'Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (18, N'Payal Chemicals', N'New Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (19, N'CI Laboratries', N'Kilkata (WB)', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (20, N'Sumitomo Chem India Pvt Ltd', N'NEw Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (21, N'AVI Oils', N'Faridabad', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (22, N'VDN Oil & Chem Ltd ', N'Ambala', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (23, N'AK Agencies', N'Pathankot', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (24, N'Swarn Interprises ', N'New Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (25, N'Sara Helth Care Ltd', N'Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (26, N'PD Lubricants', N'Sonepat  Harayana', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (27, N'SV Equiptment', N'Karolbagh New Delhi', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (28, N'Indo Chem Lab', N'Baroda , Gujrat', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (29, N'India Pharmacuitecals Ltd', N'Patna Bihar', 1, CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (30, N'FPD ASC Leh', N'NA', 1, CAST(123 AS Numeric(18, 0)))
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (31, N'IOC and BPCL', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (32, N'1', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (33, N'KILPEST INDIA LIMITED', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (34, N'COROMANDAL INTERNATIONAL LTD', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (35, N'Tagros chemical india ltd', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (36, N'Please type Supplier Name here', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (37, N'ALKLY AMINE CHEMICAL LTD', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (38, N'M/S S B Eqipments Karol Bag', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (39, N'IOC Jalandhar', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (40, N'sup', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (41, N'sub', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (42, N'kumar nath', N'NA', 1, NULL)
INSERT [dbo].[supplier] ([Id], [Name], [Address], [IsActivated], [ContactNo]) VALUES (43, N'hello', N'NA', 1, NULL)
SET IDENTITY_INSERT [dbo].[supplier] OFF
SET IDENTITY_INSERT [dbo].[tbl_Atttribute] ON 

INSERT [dbo].[tbl_Atttribute] ([TypeId], [AttributeName], [Active], [CreateduserId], [Createddate], [ModifieduserId], [Modifieddate]) VALUES (1, N'IDT', 1, 1, CAST(N'2016-01-26 11:34:47.700' AS DateTime), 1, CAST(N'2016-01-26 11:34:47.700' AS DateTime))
INSERT [dbo].[tbl_Atttribute] ([TypeId], [AttributeName], [Active], [CreateduserId], [Createddate], [ModifieduserId], [Modifieddate]) VALUES (2, N'ICT', 1, 1, CAST(N'2016-01-26 11:34:47.707' AS DateTime), 1, CAST(N'2016-01-26 11:34:47.707' AS DateTime))
INSERT [dbo].[tbl_Atttribute] ([TypeId], [AttributeName], [Active], [CreateduserId], [Createddate], [ModifieduserId], [Modifieddate]) VALUES (3, N'AWS', 1, 1, CAST(N'2016-01-26 11:34:47.710' AS DateTime), 1, CAST(N'2016-01-26 11:34:47.710' AS DateTime))
INSERT [dbo].[tbl_Atttribute] ([TypeId], [AttributeName], [Active], [CreateduserId], [Createddate], [ModifieduserId], [Modifieddate]) VALUES (4, N'Full Year', 0, 1, CAST(N'2016-01-26 11:34:47.710' AS DateTime), 1, CAST(N'2016-01-26 11:34:47.710' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Atttribute] OFF
SET IDENTITY_INSERT [dbo].[tbl_batchIdt] ON 

INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (1, N'Batch03', CAST(500.00000000000 AS Decimal(36, 11)), 7, 32, 0, CAST(N'2017-03-04 15:25:34.173' AS DateTime), 1, 1, 15, N'4th march test after deleting data')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (2, N'B1', CAST(500.00000000000 AS Decimal(36, 11)), 5, 32, 0, CAST(N'2017-03-04 15:30:25.420' AS DateTime), 1, 2, 17, N'4th March Test DW')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (3, N'loveleet koti', CAST(500.00000000000 AS Decimal(36, 11)), 1, 1, 0, CAST(N'2017-03-04 15:37:59.240' AS DateTime), 1, 3, 1018, N'Full Test 4th march')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (4, N'loveleet koti', CAST(200.00000000000 AS Decimal(36, 11)), 8, 1, 0, CAST(N'2017-03-05 19:02:33.220' AS DateTime), 1, 4, 1019, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (5, N'B1', CAST(100.00000000000 AS Decimal(36, 11)), 8, 297, 0, CAST(N'2017-03-05 19:02:50.480' AS DateTime), 1, 4, 3, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (6, N'loveleet koti', CAST(100.00000000000 AS Decimal(36, 11)), 8, 1, 0, CAST(N'2017-03-05 19:22:25.640' AS DateTime), 1, 5, 1019, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (1004, N'Batch04', CAST(500.00000000000 AS Decimal(36, 11)), 1, 32, 0, CAST(N'2017-03-14 10:49:48.787' AS DateTime), 1, 7, 16, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (1005, N'Batch1', CAST(1000.00000000000 AS Decimal(36, 11)), 7, 39, 0, CAST(N'2017-03-14 10:53:25.107' AS DateTime), 1, 8, 10, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (1006, N'Batch2', CAST(200.00000000000 AS Decimal(36, 11)), 1, 39, 1, CAST(N'2017-03-14 21:32:39.513' AS DateTime), 1, 9, 11, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (2004, N'thi', CAST(100.00000000000 AS Decimal(36, 11)), 1, 30, 1, CAST(N'2017-03-16 20:57:00.273' AS DateTime), 1, 11, 18, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (2005, N'thi', CAST(0.00000000000 AS Decimal(36, 11)), 1, 30, 1, CAST(N'2017-03-16 20:57:00.417' AS DateTime), 1, 11, 18, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (2007, N'B1', CAST(400.00000000000 AS Decimal(36, 11)), 7, 28, 1, CAST(N'2017-03-18 19:34:58.423' AS DateTime), 1, 12, 5, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (7, N'Batch03', CAST(200.00000000000 AS Decimal(36, 11)), 5, 32, 0, CAST(N'2017-03-05 19:24:36.903' AS DateTime), 1, 6, 15, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (2006, N'Batch2', CAST(200.00000000000 AS Decimal(36, 11)), 1, 39, 1, CAST(N'2017-03-16 21:29:23.540' AS DateTime), 0, 0, 11, N'')
INSERT [dbo].[tbl_batchIdt] ([id], [BatchName], [issueqty], [DepuID], [ProductID], [Qid], [createddate], [issueorder_Status], [IssueOrderId], [BID], [Remarks]) VALUES (1007, N'B1', CAST(200.00000000000 AS Decimal(36, 11)), 1, 32, 1, CAST(N'2017-03-14 22:06:37.360' AS DateTime), 1, 10, 17, N'')
SET IDENTITY_INSERT [dbo].[tbl_batchIdt] OFF
SET IDENTITY_INSERT [dbo].[tbl_IssueOrder] ON 

INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (1, 1, N'IO/4th march test/DT/2017/03/04', 7, 0, 0, 1, CAST(N'2017-03-04 15:25:57.627' AS DateTime), NULL, N'testing 4th march', CAST(N'2017-03-04 00:00:00.000' AS DateTime), 32, 500, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (2, 2, N'IO/4th march DW Test/DT/2017/03/04', 5, 0, 1, 1, CAST(N'2017-03-04 15:30:54.163' AS DateTime), NULL, N'testing 4th march', CAST(N'2017-03-04 00:00:00.000' AS DateTime), 32, 500, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (3, 3, N'IO/4th march Full Test/DT/2017/03/04', 1, 0, 0, 1, CAST(N'2017-03-04 15:38:21.230' AS DateTime), NULL, N'testing 4th march', CAST(N'2017-03-04 00:00:00.000' AS DateTime), 1, 500, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (4, 4, N'IO/testing loveleet 5th march/DT/2017/03/05', 8, 0, 1, 1, CAST(N'2017-03-05 19:03:19.590' AS DateTime), NULL, N'testing loveleet 5th march', CAST(N'2017-03-05 00:00:00.000' AS DateTime), 1, 200, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (5, 4, N'IO/testing loveleet 5th march/DT/2017/03/05', 8, 0, 1, 1, CAST(N'2017-03-05 19:03:19.590' AS DateTime), NULL, N'testing loveleet 5th march', CAST(N'2017-03-05 00:00:00.000' AS DateTime), 297, 100, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (6, 5, N'IO/5th testing 2/DT/2017/03/05', 8, 0, 0, 1, CAST(N'2017-03-05 19:23:04.910' AS DateTime), NULL, N'5th testing 2', CAST(N'2017-03-05 00:00:00.000' AS DateTime), 1, 100, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (7, 6, N'IO/5th march  testign 3/DT/2017/03/05', 5, 0, 1, 1, CAST(N'2017-03-05 19:25:04.140' AS DateTime), NULL, N'5th march  testign 3', CAST(N'2017-03-05 00:00:00.000' AS DateTime), 32, 200, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (1004, 7, N'IO/koti 14 march/DT/2017/03/14', 1, 0, 0, 1, CAST(N'2017-03-14 10:50:11.417' AS DateTime), NULL, N'koti 14 march testing', CAST(N'2017-03-14 00:00:00.000' AS DateTime), 32, 500, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (1005, 8, N'IO/14 th testing march/DT/2017/03/14', 7, 0, 1, 1, CAST(N'2017-03-14 10:53:47.890' AS DateTime), NULL, N'14th testing march 2nd', CAST(N'2017-03-14 00:00:00.000' AS DateTime), 39, 1000, N'ICT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (1006, 9, N'IO/testing loveleet 14th/DT/2017/03/14', 1, 1, 1, 1, CAST(N'2017-03-14 21:33:07.247' AS DateTime), NULL, N'14th march', CAST(N'2017-03-14 00:00:00.000' AS DateTime), 39, 200, N'IDT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (2004, 11, N'IO/testing 16th march/DT/2017/03/16', 1, 1, 0, 1, CAST(N'2017-03-16 20:58:12.360' AS DateTime), NULL, N'testing 16th march', CAST(N'2017-03-16 00:00:00.000' AS DateTime), 30, 100, N'IDT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (2005, 12, N'IO/testing 18th/DT/2017/03/18', 7, 1, 1, 1, CAST(N'2017-03-18 19:35:18.897' AS DateTime), NULL, N'testing 18th', CAST(N'2017-03-18 00:00:00.000' AS DateTime), 28, 400, N'IDT')
INSERT [dbo].[tbl_IssueOrder] ([ID], [IssueOrderId], [IssueOrderNo], [DepotId], [QuarterId], [OrderStatusId], [Active], [CreateDate], [createduserid], [Authority], [issueorder_date], [productID], [issuequantity], [IDTICTAWS]) VALUES (1007, 10, N'IO/testing again14th/DT/2017/03/14', 1, 1, 1, 1, CAST(N'2017-03-14 22:06:56.130' AS DateTime), NULL, N'testong again14th', CAST(N'2017-03-14 00:00:00.000' AS DateTime), 32, 200, N'IDT')
SET IDENTITY_INSERT [dbo].[tbl_IssueOrder] OFF
SET IDENTITY_INSERT [dbo].[tbl_issuevoucherdetail] ON 

INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (2004, 1, N'2/IV/789 DT20-11-2016', 1, CAST(N'2016-11-20 19:55:48.110' AS DateTime), 1, CAST(N'2016-11-20 19:55:48.110' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (2005, 1, N'3/IV/45 DT20-11-2016', 1, CAST(N'2016-11-20 23:49:18.237' AS DateTime), 1, CAST(N'2016-11-20 23:49:18.237' AS DateTime), 1, 3)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (3004, 2, N'2/IV/456 DT03-12-2016', 1, CAST(N'2016-12-03 16:05:06.727' AS DateTime), 1, CAST(N'2016-12-03 16:05:06.727' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (4004, 7, N'1/IV/me DT07-12-2016', 1, CAST(N'2016-12-07 23:28:26.207' AS DateTime), 1, CAST(N'2016-12-07 23:28:26.207' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (5004, 8, N'1/IV/testing 12 decem DT12-12-2016', 1, CAST(N'2016-12-12 18:41:22.257' AS DateTime), 1, CAST(N'2016-12-12 18:41:22.257' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (6004, 13, N'2/IV/testing issue voucher DT04-01-2017', 1, CAST(N'2017-01-04 20:47:05.517' AS DateTime), 1, CAST(N'2017-01-04 20:47:05.517' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (7004, 14, N'2/IV/0105 DT05-01-2017', 1, CAST(N'2017-01-05 22:11:42.273' AS DateTime), 1, CAST(N'2017-01-05 22:11:42.273' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (8004, 15, N'3/IV/2154 DT28-01-2017', 1, CAST(N'2017-01-28 23:40:09.600' AS DateTime), 1, CAST(N'2017-01-28 23:40:09.600' AS DateTime), 1, 3)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (9004, 16, N'1/IV/29 testing jan DT29-01-2017', 1, CAST(N'2017-01-29 22:05:34.540' AS DateTime), 1, CAST(N'2017-01-29 22:05:34.540' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (10004, 18, N'2/IV/LOVELEET DT25-02-2017', 1, CAST(N'2017-02-25 16:24:08.580' AS DateTime), 1, CAST(N'2017-02-25 16:24:08.580' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (10005, 20, N'2/IV/27 testing DT27-02-2017', 1, CAST(N'2017-02-27 14:21:14.673' AS DateTime), 1, CAST(N'2017-02-27 14:21:14.673' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11004, 22, N'2/IV/2ht1 DT04-03-2017', 1, CAST(N'2017-03-04 14:31:43.993' AS DateTime), 1, CAST(N'2017-03-04 14:31:43.993' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11005, 3, N'1/IV/4th march test DT04-03-2017', 1, CAST(N'2017-03-04 15:39:08.133' AS DateTime), 1, CAST(N'2017-03-04 15:39:08.133' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11006, 4, N'1/IV/5th jantesting DT05-03-2017', 1, CAST(N'2017-03-05 19:17:12.483' AS DateTime), 1, CAST(N'2017-03-05 19:17:12.483' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11007, 4, N'3/IV/5th march testing  DT05-03-2017', 1, CAST(N'2017-03-05 19:20:59.127' AS DateTime), 1, CAST(N'2017-03-05 19:20:59.127' AS DateTime), 1, 3)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11008, 5, N'1/IV/1/IV/5th jantesting DT05-03-2017 DT05-03-2017', 1, CAST(N'2017-03-05 19:23:49.150' AS DateTime), 1, CAST(N'2017-03-05 19:23:49.150' AS DateTime), 1, 1)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (12006, 8, N'2/IV/loveleet testing 14 march DT14-03-2017', 1, CAST(N'2017-03-14 10:54:21.953' AS DateTime), 1, CAST(N'2017-03-14 10:54:21.953' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (12007, 9, N'2/IV/testing 14th march 21:33 DT14-03-2017', 1, CAST(N'2017-03-14 21:33:39.057' AS DateTime), 1, CAST(N'2017-03-14 21:33:39.057' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (13006, 12, N'2/IV/testing vehicle 18th DT18-03-2017', 1, CAST(N'2017-03-18 19:35:38.567' AS DateTime), 1, CAST(N'2017-03-18 19:35:38.567' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (11009, 6, N'2/IV/testing 5th march DT05-03-2017', 1, CAST(N'2017-03-05 19:25:39.627' AS DateTime), 1, CAST(N'2017-03-05 19:25:39.627' AS DateTime), 1, 2)
INSERT [dbo].[tbl_issuevoucherdetail] ([Id], [IssueorderId], [IssusevoucherName], [Active], [Createddate], [Createdby], [Modifieddate], [Modifiedby], [Cat_ID]) VALUES (12008, 10, N'2/IV/test 14th dw DT14-03-2017', 1, CAST(N'2017-03-14 22:07:44.160' AS DateTime), 1, CAST(N'2017-03-14 22:07:44.160' AS DateTime), 1, 2)
SET IDENTITY_INSERT [dbo].[tbl_issuevoucherdetail] OFF
SET IDENTITY_INSERT [dbo].[tbl_loadtallydetail] ON 

INSERT [dbo].[tbl_loadtallydetail] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [DriverName], [Rank], [UnitNo], [DateofGenration], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [Authority], [Through], [LoadtallyId], [Remarks]) VALUES (1004, N'LT/1001 DT20-11-2016', 1, N'5', N'iu', N'i', N'1', CAST(N'2016-11-20 23:31:09.253' AS DateTime), 1, 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), N'Loveleet', N'56', 1006, N'l')
INSERT [dbo].[tbl_loadtallydetail] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [DriverName], [Rank], [UnitNo], [DateofGenration], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [Authority], [Through], [LoadtallyId], [Remarks]) VALUES (1005, N'LT/4 DT20-11-2016', 1, N'V12', N'iu', N'i', N'1', CAST(N'2016-11-20 23:31:09.253' AS DateTime), 1, 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), N'Loveleet', N'56', 1007, N'lk')
INSERT [dbo].[tbl_loadtallydetail] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [DriverName], [Rank], [UnitNo], [DateofGenration], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [Authority], [Through], [LoadtallyId], [Remarks]) VALUES (1006, N'LT/4 DT20-11-2016', 1, N'V1', N'iu', N'i', N'1', CAST(N'2016-11-20 23:31:09.253' AS DateTime), 1, 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), 3, CAST(N'2016-11-20 23:31:09.253' AS DateTime), N'koti', N'56', 1008, N'lkk')
SET IDENTITY_INSERT [dbo].[tbl_loadtallydetail] OFF
SET IDENTITY_INSERT [dbo].[tbl_loadtaly] ON 

INSERT [dbo].[tbl_loadtaly] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [loadtally_status], [Remarks]) VALUES (1006, N'LT/1001 DT20-11-2016', 1, N'5', 1, 1, CAST(N'2016-11-20 23:31:09.253' AS DateTime), 1, CAST(N'2016-11-20 23:31:09.253' AS DateTime), 1, N'')
INSERT [dbo].[tbl_loadtaly] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [loadtally_status], [Remarks]) VALUES (1007, N'LT/4 DT20-11-2016', 1, N'V12', 1, 1, CAST(N'2016-11-20 23:36:33.130' AS DateTime), 1, CAST(N'2016-11-20 23:36:33.130' AS DateTime), 1, N'')
INSERT [dbo].[tbl_loadtaly] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [loadtally_status], [Remarks]) VALUES (1008, N'LT/4 DT20-11-2016', 1, N'V1', 1, 1, CAST(N'2016-11-20 23:49:35.997' AS DateTime), 1, CAST(N'2016-11-20 23:49:35.997' AS DateTime), 1, N'')
INSERT [dbo].[tbl_loadtaly] ([Id], [loadtallyNumber], [IssueorderId], [vechileNo], [Active], [Createdby], [Createddate], [Modifiedby], [Modifieddate], [loadtally_status], [Remarks]) VALUES (2006, N'LT/4 DT03-12-2016', 2, N'V14', 1, 1, CAST(N'2016-12-03 16:05:33.230' AS DateTime), 1, CAST(N'2016-12-03 16:05:33.230' AS DateTime), 0, N'')
SET IDENTITY_INSERT [dbo].[tbl_loadtaly] OFF
SET IDENTITY_INSERT [dbo].[tbl_vechileMaster] ON 

INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (1, N'Unit1', N'V2', N'D2', N'R2', 1, CAST(N'2016-06-30 12:36:31.437' AS DateTime), NULL, CAST(N'2016-06-30 12:36:31.437' AS DateTime), NULL, 0, N'A2', 1, N'U2', N'', N'none again')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (2, N'Unit2', N'V12', N'D12', N'', 1, CAST(N'2016-06-30 12:39:33.497' AS DateTime), NULL, CAST(N'2016-06-30 12:39:33.497' AS DateTime), NULL, 1, N'', 2, N'', N'L12', N'None')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (3, N'Unit1', N'V1', N'D1', N'R1', 1, CAST(N'2016-06-30 12:41:33.423' AS DateTime), NULL, CAST(N'2016-06-30 12:41:33.423' AS DateTime), NULL, 1, N'A1', 1, N'U1', N'', N'none')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (4, N'Unit1', N'V10', N'D10', N'', 1, CAST(N'2016-06-30 13:16:39.937' AS DateTime), NULL, CAST(N'2016-06-30 13:16:39.937' AS DateTime), NULL, 1, N'', 2, N'', N'L10', N'no')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (5, N'Unit1', N'V11', N'V12', N'', 1, CAST(N'2016-06-30 13:21:47.890' AS DateTime), NULL, CAST(N'2016-06-30 13:21:47.890' AS DateTime), NULL, 0, N'', 2, N'', N'L12', N'none')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (6, N'Unit3', N'V14', N'v14', N'', 1, CAST(N'2016-07-01 06:33:59.523' AS DateTime), NULL, CAST(N'2016-07-01 06:33:59.523' AS DateTime), NULL, 0, N'', 2, N'', N'v14', N'14')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (7, N'Unit4', N'1', N'1', N'', 1, CAST(N'2016-07-01 06:47:29.413' AS DateTime), NULL, CAST(N'2016-07-01 06:47:29.413' AS DateTime), NULL, 0, N'', 2, N'', N'1', N'1')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (8, N'Unit4', N'2', N'2', N'', 1, CAST(N'2016-07-01 06:47:29.430' AS DateTime), NULL, CAST(N'2016-07-01 06:47:29.430' AS DateTime), NULL, 0, N'', 2, N'', N'2', N'2')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (9, N'Unit4', N'3', N'3', N'', 1, CAST(N'2016-07-01 06:47:29.450' AS DateTime), NULL, CAST(N'2016-07-01 06:47:29.450' AS DateTime), NULL, 0, N'', 2, N'', N'3', N'3')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (10, N'Unit4', N'4', N'4', N'', 1, CAST(N'2016-07-01 06:47:29.467' AS DateTime), NULL, CAST(N'2016-07-01 06:47:29.467' AS DateTime), NULL, 0, N'', 2, N'', N'4', N'4')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (11, N'Unit4', N'5', N'5', N'', 1, CAST(N'2016-07-01 06:47:29.483' AS DateTime), NULL, CAST(N'2016-07-01 06:47:29.483' AS DateTime), NULL, 0, N'', 2, N'', N'5', N'5')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (12, N'Unit3', N'1', N'1', N'1', 1, CAST(N'2016-07-01 06:53:48.040' AS DateTime), NULL, CAST(N'2016-07-01 06:53:48.040' AS DateTime), NULL, 0, N'1', 1, N'1', N'', N'1')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (13, N'Unit3', N'2', N'2', N'2', 1, CAST(N'2016-07-01 06:53:48.053' AS DateTime), NULL, CAST(N'2016-07-01 06:53:48.053' AS DateTime), NULL, 0, N'2', 1, N'2', N'', N'2')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (14, N'Unit3', N'3', N'3', N'3', 1, CAST(N'2016-07-01 06:53:48.073' AS DateTime), NULL, CAST(N'2016-07-01 06:53:48.073' AS DateTime), NULL, 0, N'3', 1, N'3', N'', N'3')
INSERT [dbo].[tbl_vechileMaster] ([Id], [Through], [VechileNumber], [DriverName], [Rank], [IsActive], [Createddate], [CreateduserId], [Modifieddate], [Modifieduserid], [loadtallystatus], [ArmyNo], [vechileType], [unitNo], [LicenseNo], [Remarks]) VALUES (15, N'Unit3', N'4', N'4', N'4', 1, CAST(N'2016-07-01 06:53:48.087' AS DateTime), NULL, CAST(N'2016-07-01 06:53:48.087' AS DateTime), NULL, 0, N'4', 1, N'4', N'', N'4')
SET IDENTITY_INSERT [dbo].[tbl_vechileMaster] OFF
SET IDENTITY_INSERT [dbo].[tbl_vechileMaster_Type] ON 

INSERT [dbo].[tbl_vechileMaster_Type] ([VtypeId], [Vtypename], [Isactive], [Createddate], [Modifieddate], [Createduserid], [ModifieduserId]) VALUES (1, N'DD', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_vechileMaster_Type] ([VtypeId], [Vtypename], [Isactive], [Createddate], [Modifieddate], [Createduserid], [ModifieduserId]) VALUES (2, N'CHT', 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_vechileMaster_Type] OFF
SET IDENTITY_INSERT [dbo].[tblExpensePMContainer] ON 

INSERT [dbo].[tblExpensePMContainer] ([Id], [ExpenseVoucherNo], [PMContainerId], [Quantity], [IsSentfromCP], [AddedBy], [AddedOn], [ModifiedOn], [ModifiedBy], [Remarks]) VALUES (2, N'', 1, CAST(5.000 AS Decimal(36, 3)), 0, 1, CAST(N'2016-06-25 00:19:23.467' AS DateTime), CAST(N'2016-06-25 00:42:02.813' AS DateTime), 1, N'')
SET IDENTITY_INSERT [dbo].[tblExpensePMContainer] OFF
SET IDENTITY_INSERT [dbo].[tblIssueVoucherDetail] ON 

INSERT [dbo].[tblIssueVoucherDetail] ([Id], [IssueOrderId], [IssueVoucherName], [DateOfGeneratation], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'1', N'2/IV/789 DT20-11-2016', CAST(N'2016-11-20 19:55:48.110' AS DateTime), 1, CAST(N'2016-11-20 19:55:48.110' AS DateTime), 1, CAST(N'2016-11-20 19:55:48.110' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblIssueVoucherDetail] OFF
SET IDENTITY_INSERT [dbo].[tblIssueVoucherVehicleDetail] ON 

INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1, N'2/IV/456 DT03-12-2016', 32, N'V2', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-04 15:34:09.923' AS DateTime), 0, CAST(N'2017-03-04 15:34:09.923' AS DateTime), 0, CAST(N'2017-03-04 00:00:00.000' AS DateTime), N'', 0, 2, 2, N'B1', N'100', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (2, N'1/IV/4th march test DT04-03-2017', 1, N'1', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-04 15:39:08.137' AS DateTime), 0, CAST(N'2017-03-04 15:39:08.137' AS DateTime), 0, CAST(N'2017-03-04 00:00:00.000' AS DateTime), N'', 0, 1, 3, N'loveleet koti', N'10X10', N'', 1019, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (3, N'2/IV/456 DT03-12-2016', 32, N'V2', CAST(10.00 AS Decimal(9, 2)), CAST(200.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-04 18:01:42.557' AS DateTime), 0, CAST(N'2017-03-04 18:01:42.557' AS DateTime), 0, CAST(N'2017-03-04 00:00:00.000' AS DateTime), N'', 0, 2, 2, N'B1', N'200', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (5, N'1/IV/5th jantesting DT05-03-2017', 1, N'V2', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-05 19:17:12.520' AS DateTime), 0, CAST(N'2017-03-05 19:17:12.520' AS DateTime), 0, CAST(N'2017-03-05 00:00:00.000' AS DateTime), N'', 0, 1, 5, N'loveleet koti', N'10X10', N'', 1019, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (6, N'3/IV/5th march testing  DT05-03-2017', 297, N'V2', CAST(10.00 AS Decimal(9, 2)), CAST(50.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-05 19:20:59.147' AS DateTime), 0, CAST(N'2017-03-05 19:20:59.147' AS DateTime), 0, CAST(N'2017-03-05 00:00:00.000' AS DateTime), N'', 0, 3, 5, N'B1', N'5X10', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (7, N'1/IV/5th jantesting DT05-03-2017', 1, N'V12', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-05 19:21:39.377' AS DateTime), 0, CAST(N'2017-03-05 19:21:39.377' AS DateTime), 0, CAST(N'2017-03-05 00:00:00.000' AS DateTime), N'', 0, 1, 5, N'loveleet koti', N'10X10', N'', 1019, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (8, N'2/IV/testing 5th march DT05-03-2017', 32, N'V12', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-05 19:25:39.660' AS DateTime), 0, CAST(N'2017-03-05 19:25:39.660' AS DateTime), 0, CAST(N'2017-03-05 00:00:00.000' AS DateTime), N'', 0, 2, 7, N'Batch03', N'10X10', N'', 15, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1005, N'2/IV/loveleet testing 14 march DT14-03-2017', 39, N'V1', CAST(10.00 AS Decimal(9, 2)), CAST(300.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-14 10:54:21.987' AS DateTime), 0, CAST(N'2017-03-14 10:54:21.987' AS DateTime), 0, CAST(N'2017-03-14 00:00:00.000' AS DateTime), N'', 0, 2, 1005, N'Batch1', N'30X10', N'', 10, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1006, N'2/IV/loveleet testing 14 march DT14-03-2017', 39, N'2', CAST(10.00 AS Decimal(9, 2)), CAST(200.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-14 12:32:06.980' AS DateTime), 0, CAST(N'2017-03-14 12:32:06.980' AS DateTime), 0, CAST(N'2017-03-14 00:00:00.000' AS DateTime), N'', 0, 2, 1005, N'Batch1', N'20X10', N'', 10, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1007, N'2/IV/testing 14th march 21:33 DT14-03-2017', 39, N'4', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-14 21:33:39.087' AS DateTime), 0, CAST(N'2017-03-14 21:33:39.087' AS DateTime), 0, CAST(N'2017-03-14 00:00:00.000' AS DateTime), N'', 0, 2, 1006, N'Batch2', N'10X10', N'', 11, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1008, N'2/IV/test 14th dw DT14-03-2017', 32, N'V12', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-14 22:07:44.187' AS DateTime), 0, CAST(N'2017-03-14 22:07:44.187' AS DateTime), 0, CAST(N'2017-03-14 00:00:00.000' AS DateTime), N'', 0, 2, 1007, N'B1', N'100', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (1009, N'2/IV/test 14th dw DT14-03-2017', 32, N'V2', CAST(10.00 AS Decimal(9, 2)), CAST(10.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-14 22:19:59.710' AS DateTime), 0, CAST(N'2017-03-14 22:19:59.710' AS DateTime), 0, CAST(N'2017-03-14 00:00:00.000' AS DateTime), N'', 0, 2, 1007, N'B1', N'10', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (2005, N'2/IV/testing vehicle 18th DT18-03-2017', 28, N'V12', CAST(10.00 AS Decimal(9, 2)), CAST(200.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-18 19:35:38.583' AS DateTime), 0, CAST(N'2017-03-18 19:35:38.583' AS DateTime), 0, CAST(N'2017-03-18 00:00:00.000' AS DateTime), N'', 0, 2, 2007, N'B1', N'200', N'', 17, 0, NULL)
INSERT [dbo].[tblIssueVoucherVehicleDetail] ([Id], [IssueVoucherId], [ProductId], [VehicleNo], [PMQuantity], [StockQuantity], [VoucherRemarks], [Active], [CreateDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [dateofgenration], [Through], [issueVoucher_status], [Cat_ID], [issueorderID], [batchno], [FormatFull], [FormatLoose], [BID], [FullOccupied], [VehicleId]) VALUES (2006, N'2/IV/testing vehicle 18th DT18-03-2017', 28, N'V12', CAST(10.00 AS Decimal(9, 2)), CAST(100.00000000000 AS Decimal(36, 11)), N'', 1, CAST(N'2017-03-18 19:36:20.313' AS DateTime), 0, CAST(N'2017-03-18 19:36:20.313' AS DateTime), 0, CAST(N'2017-03-18 00:00:00.000' AS DateTime), N'', 0, 2, 2007, N'B1', N'100', N'', 17, 0, NULL)
SET IDENTITY_INSERT [dbo].[tblIssueVoucherVehicleDetail] OFF
SET IDENTITY_INSERT [dbo].[tblQuarter] ON 

INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (1, N'Apr-Jun', 2015, 1, N'2015-2016')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (2, N'Jul-Sep', 2015, 2, N'2015-2016')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (3, N'Oct-Dec', 2015, 3, N'2015-2016')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (4, N'Jan-Mar', 2015, 4, N'2015-2016')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (5, N'Apr-Jun', 2016, 1, N'2016-2017')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (6, N'Jul-Sep', 2016, 2, N'2016-2017')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (7, N'Oct-Dec', 2016, 3, N'2016-2017')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (8, N'Jan-Mar', 2016, 4, N'2016-2017')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (9, N'Apr-Jun', 2017, 1, N'2017-2018')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (10, N'Jul-Sep', 2017, 2, N'2017-2018')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (11, N'Oct-Dec', 2017, 3, N'2017-2018')
INSERT [dbo].[tblQuarter] ([QuarterId], [QuarterName], [QuarterYear], [QuarterRank], [YearRange]) VALUES (12, N'Jan-Mar', 2017, 4, N'2017-2018')
SET IDENTITY_INSERT [dbo].[tblQuarter] OFF
SET IDENTITY_INSERT [dbo].[tblWarehouse] ON 

INSERT [dbo].[tblWarehouse] ([ID], [WareHouseNo], [IsActive], [AddedOn], [ModifiedOn], [AddedBy], [ModifiedBy]) VALUES (1, N'WH1', 1, CAST(N'2016-06-19 06:06:09.103' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[tblWarehouse] ([ID], [WareHouseNo], [IsActive], [AddedOn], [ModifiedOn], [AddedBy], [ModifiedBy]) VALUES (2, N'WH2', 1, CAST(N'2016-06-19 06:06:18.943' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[tblWarehouse] ([ID], [WareHouseNo], [IsActive], [AddedOn], [ModifiedOn], [AddedBy], [ModifiedBy]) VALUES (3, N'WH3', 1, CAST(N'2016-06-19 06:06:27.743' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[tblWarehouse] ([ID], [WareHouseNo], [IsActive], [AddedOn], [ModifiedOn], [AddedBy], [ModifiedBy]) VALUES (4, N'WH4', 1, CAST(N'2016-06-19 06:06:33.413' AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[tblWarehouse] OFF
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([User_ID], [FirstName], [UserCode], [LastName], [User_Name], [RoleId], [Password], [Country], [State], [City], [Address], [ContactNo], [IsActive], [Addedon], [AddedBy], [Modifiedon], [ModifiedBy], [ArmyNo], [StartDate], [EndDate]) VALUES (1, N'admin', N'1', N'admin', N'admin', 1, N'123', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserMaster] ([User_ID], [FirstName], [UserCode], [LastName], [User_Name], [RoleId], [Password], [Country], [State], [City], [Address], [ContactNo], [IsActive], [Addedon], [AddedBy], [Modifiedon], [ModifiedBy], [ArmyNo], [StartDate], [EndDate]) VALUES (2, N'Admin', N'UC-1', N'Test', N'Admin', 17, N'123', 98, 1743, 1, N'vpo', N'9780020208', 1, CAST(N'2015-02-06 15:51:09.280' AS DateTime), 786, NULL, NULL, N'123', CAST(N'2015-04-17 00:00:00.000' AS DateTime), CAST(N'2015-04-17 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
ALTER TABLE [dbo].[AddPMContainer]  WITH CHECK ADD  CONSTRAINT [FK_AddPMContainer_CategoryMaster] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryMaster] ([ID])
GO
ALTER TABLE [dbo].[AddPMContainer] CHECK CONSTRAINT [FK_AddPMContainer_CategoryMaster]
GO
ALTER TABLE [dbo].[AddPMContainer]  WITH CHECK ADD  CONSTRAINT [FK_AddPMContainer_PMandContainerMaster] FOREIGN KEY([PMID])
REFERENCES [dbo].[PMandContainerMaster] ([Id])
GO
ALTER TABLE [dbo].[AddPMContainer] CHECK CONSTRAINT [FK_AddPMContainer_PMandContainerMaster]
GO
ALTER TABLE [dbo].[BatchDepot]  WITH CHECK ADD  CONSTRAINT [FK_BatchDepot_DepuMaster] FOREIGN KEY([DepotId])
REFERENCES [dbo].[DepuMaster] ([Depu_Id])
GO
ALTER TABLE [dbo].[BatchDepot] CHECK CONSTRAINT [FK_BatchDepot_DepuMaster]
GO
ALTER TABLE [dbo].[BatchMaster]  WITH CHECK ADD  CONSTRAINT [FK_BatchMaster_DepuMaster] FOREIGN KEY([DepotID])
REFERENCES [dbo].[DepuMaster] ([Depu_Id])
GO
ALTER TABLE [dbo].[BatchMaster] CHECK CONSTRAINT [FK_BatchMaster_DepuMaster]
GO
ALTER TABLE [dbo].[BatchMaster]  WITH CHECK ADD  CONSTRAINT [FK_BatchMaster_ProductMaster] FOREIGN KEY([PID])
REFERENCES [dbo].[ProductMaster] ([Product_ID])
GO
ALTER TABLE [dbo].[BatchMaster] CHECK CONSTRAINT [FK_BatchMaster_ProductMaster]
GO
ALTER TABLE [dbo].[CategoryMaster]  WITH CHECK ADD  CONSTRAINT [FK_CategoryMaster_CategoryType] FOREIGN KEY([Category_TypeId])
REFERENCES [dbo].[CategoryType] ([ID])
GO
ALTER TABLE [dbo].[CategoryMaster] CHECK CONSTRAINT [FK_CategoryMaster_CategoryType]
GO
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_StatesMaster] FOREIGN KEY([StateID])
REFERENCES [dbo].[StatesMaster] ([ID])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_StatesMaster]
GO
ALTER TABLE [dbo].[EslMaster]  WITH CHECK ADD  CONSTRAINT [FK_EslMaster_UnitMaster] FOREIGN KEY([Unit_Id])
REFERENCES [dbo].[UnitMaster] ([Unit_Id])
GO
ALTER TABLE [dbo].[EslMaster] CHECK CONSTRAINT [FK_EslMaster_UnitMaster]
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseVoucherMaster_BatchMaster] FOREIGN KEY([BatchID])
REFERENCES [dbo].[BatchMaster] ([BID])
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster] CHECK CONSTRAINT [FK_ExpenseVoucherMaster_BatchMaster]
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseVoucherMaster_CategoryMaster] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryMaster] ([ID])
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster] CHECK CONSTRAINT [FK_ExpenseVoucherMaster_CategoryMaster]
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseVoucherMaster_ProductMaster] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductMaster] ([Product_ID])
GO
ALTER TABLE [dbo].[ExpenseVoucherMaster] CHECK CONSTRAINT [FK_ExpenseVoucherMaster_ProductMaster]
GO
ALTER TABLE [dbo].[Formation]  WITH CHECK ADD  CONSTRAINT [FK_Formation_CommandMaster] FOREIGN KEY([CommandId])
REFERENCES [dbo].[CommandMaster] ([Id])
GO
ALTER TABLE [dbo].[Formation] CHECK CONSTRAINT [FK_Formation_CommandMaster]
GO
ALTER TABLE [dbo].[IssueVoucher]  WITH CHECK ADD  CONSTRAINT [FK_IssueVoucher_IDT] FOREIGN KEY([IdtId])
REFERENCES [dbo].[IDT] ([Id])
GO
ALTER TABLE [dbo].[IssueVoucher] CHECK CONSTRAINT [FK_IssueVoucher_IDT]
GO
ALTER TABLE [dbo].[IssueVoucher]  WITH CHECK ADD  CONSTRAINT [FK_IssueVoucher_IssueVoucher] FOREIGN KEY([Id])
REFERENCES [dbo].[IssueVoucher] ([Id])
GO
ALTER TABLE [dbo].[IssueVoucher] CHECK CONSTRAINT [FK_IssueVoucher_IssueVoucher]
GO
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_ProductMaster_CategoryMaster] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[CategoryMaster] ([ID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_ProductMaster_CategoryMaster]
GO
ALTER TABLE [dbo].[RoleMaster]  WITH CHECK ADD  CONSTRAINT [FK_RoleMaster_DeptMaster] FOREIGN KEY([DeptId])
REFERENCES [dbo].[DeptMaster] ([Id])
GO
ALTER TABLE [dbo].[RoleMaster] CHECK CONSTRAINT [FK_RoleMaster_DeptMaster]
GO
ALTER TABLE [dbo].[StatesMaster]  WITH CHECK ADD  CONSTRAINT [FK_StatesMaster_CountryMaster] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryMaster] ([ID])
GO
ALTER TABLE [dbo].[StatesMaster] CHECK CONSTRAINT [FK_StatesMaster_CountryMaster]
GO
ALTER TABLE [dbo].[Stock_QuantityMaster]  WITH CHECK ADD  CONSTRAINT [FK_Stock_QuantityMaster_Stock_QuantityMaster] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductMaster] ([Product_ID])
GO
ALTER TABLE [dbo].[Stock_QuantityMaster] CHECK CONSTRAINT [FK_Stock_QuantityMaster_Stock_QuantityMaster]
GO
ALTER TABLE [dbo].[Stock_StockIn]  WITH CHECK ADD  CONSTRAINT [FK_StockIn_Stock_BatchMaster] FOREIGN KEY([LotBatchId])
REFERENCES [dbo].[Stock_BatchMaster] ([BatchId])
GO
ALTER TABLE [dbo].[Stock_StockIn] CHECK CONSTRAINT [FK_StockIn_Stock_BatchMaster]
GO
ALTER TABLE [dbo].[StockMaster]  WITH CHECK ADD  CONSTRAINT [FK_StockMaster_ProductMaster] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductMaster] ([Product_ID])
GO
ALTER TABLE [dbo].[StockMaster] CHECK CONSTRAINT [FK_StockMaster_ProductMaster]
GO
ALTER TABLE [dbo].[StockTransfer]  WITH CHECK ADD  CONSTRAINT [FK_StockTransfer_CategoryMaster] FOREIGN KEY([CategoryMasterId])
REFERENCES [dbo].[CategoryMaster] ([ID])
GO
ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_CategoryMaster]
GO
ALTER TABLE [dbo].[StockTransfer]  WITH CHECK ADD  CONSTRAINT [FK_StockTransfer_DepuMaster] FOREIGN KEY([DepuMasterId])
REFERENCES [dbo].[DepuMaster] ([Depu_Id])
GO
ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_DepuMaster]
GO
ALTER TABLE [dbo].[StockTransfer]  WITH CHECK ADD  CONSTRAINT [FK_StockTransfer_Indent] FOREIGN KEY([IndentId])
REFERENCES [dbo].[IDT] ([Id])
GO
ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_Indent]
GO
ALTER TABLE [dbo].[StockTransfer]  WITH CHECK ADD  CONSTRAINT [FK_StockTransfer_StockTransfer] FOREIGN KEY([TypeOfOrderId])
REFERENCES [dbo].[TypeOfOrder] ([ID])
GO
ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_StockTransfer]
GO
ALTER TABLE [dbo].[tblExpensePMContainer]  WITH CHECK ADD  CONSTRAINT [FK_tblExpensePMContainer_AddPMContainer] FOREIGN KEY([PMContainerId])
REFERENCES [dbo].[AddPMContainer] ([ID])
GO
ALTER TABLE [dbo].[tblExpensePMContainer] CHECK CONSTRAINT [FK_tblExpensePMContainer_AddPMContainer]
GO
ALTER TABLE [dbo].[tblLPCP]  WITH CHECK ADD  CONSTRAINT [FK_tblLPCP_OriginalManufacture ] FOREIGN KEY([OriginalMfgID])
REFERENCES [dbo].[OriginalManufacture ] ([Id])
GO
ALTER TABLE [dbo].[tblLPCP] CHECK CONSTRAINT [FK_tblLPCP_OriginalManufacture ]
GO
ALTER TABLE [dbo].[tblLPCP]  WITH CHECK ADD  CONSTRAINT [FK_tblLPCP_ProductMaster] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductMaster] ([Product_ID])
GO
ALTER TABLE [dbo].[tblLPCP] CHECK CONSTRAINT [FK_tblLPCP_ProductMaster]
GO
ALTER TABLE [dbo].[tblLPCP]  WITH CHECK ADD  CONSTRAINT [FK_tblLPCP_supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[supplier] ([Id])
GO
ALTER TABLE [dbo].[tblLPCP] CHECK CONSTRAINT [FK_tblLPCP_supplier]
GO
ALTER TABLE [dbo].[tblSection]  WITH CHECK ADD  CONSTRAINT [FK_tblSection_tblSection] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[tblWarehouse] ([ID])
GO
ALTER TABLE [dbo].[tblSection] CHECK CONSTRAINT [FK_tblSection_tblSection]
GO
ALTER TABLE [dbo].[tblSection]  WITH CHECK ADD  CONSTRAINT [FK_tblSection_tblSection1] FOREIGN KEY([IsParent])
REFERENCES [dbo].[tblSection] ([ID])
GO
ALTER TABLE [dbo].[tblSection] CHECK CONSTRAINT [FK_tblSection_tblSection1]
GO
ALTER TABLE [dbo].[UnitMaster]  WITH CHECK ADD  CONSTRAINT [FK_UnitMaster_DepuMaster] FOREIGN KEY([Depu_Id])
REFERENCES [dbo].[DepuMaster] ([Depu_Id])
GO
ALTER TABLE [dbo].[UnitMaster] CHECK CONSTRAINT [FK_UnitMaster_DepuMaster]
GO
ALTER TABLE [dbo].[UnitMaster]  WITH CHECK ADD  CONSTRAINT [FK_UnitMaster_UnitMaster] FOREIGN KEY([Unit_Id])
REFERENCES [dbo].[UnitMaster] ([Unit_Id])
GO
ALTER TABLE [dbo].[UnitMaster] CHECK CONSTRAINT [FK_UnitMaster_UnitMaster]
GO
ALTER TABLE [dbo].[UserMaster]  WITH CHECK ADD  CONSTRAINT [FK_UserMaster_RoleMaster] FOREIGN KEY([RoleId])
REFERENCES [dbo].[RoleMaster] ([Role_ID])
GO
ALTER TABLE [dbo].[UserMaster] CHECK CONSTRAINT [FK_UserMaster_RoleMaster]
GO
/****** Object:  StoredProcedure [dbo].[managecommand]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[managecommand]
(@Id int=null,
@Name varchar(max)=null
           ,@Descripition varchar(max)=null
           ,@IsActive bit=null
           ,@Addedby int=null
           ,@Addedon datetime=null
           ,@Updatedby int=null
           ,@UndatedOn datetime=null,
           @Action varchar=null
)as

if(@Action='insert')
	begin		

		INSERT INTO [CommandMaster]
           ([Name]
           ,[Descripition]
           ,[IsActive]
           ,[Addedby]
           ,[Addedon]
           ,[Updatedby]
           ,[UndatedOn])
     VALUES
           (@Name
           ,@Descripition
           ,@IsActive
           ,@Addedby
           ,GETDATE()
           ,@Updatedby
           ,GETDATE())
	end


GO
/****** Object:  StoredProcedure [dbo].[proc_getSeedNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_getSeedNumber]   
-- Added by Rohit
@IO nvarchar(max) = null,
@output int = null output,
@getIO nvarchar(max) =null

AS BEGIN
select @output = MAX(IssueOrderId) from tbl_IssueOrder group by IssueOrderId
BEGIN
if(@output is not null)
   BEGIN 
   select top 1 @getIO = IssueOrderNo from tbl_IssueOrder where IssueOrderNo = @IO and IssueOrderId = @output  group by IssueOrderNo order by IssueOrderNo desc
   if(@getIO is not null)
       set @output = @output
	else
       set @output = @output +1 
    END
else
  set @output = 1 

END
select @output
END
---  Commentted by Rohit
--@SeedNum nvarchar(max) ,
--@output int output

--AS      
--BEGIN      
 
--Declare @seedNumber varchar(max)
--CREATE table #tbl (items varchar(max),id int)
--Insert into  #tbl
--SELECT items, ROW_NUMBER() OVER (ORDER BY items desc) FROM [dbo].[Split] (@SeedNum, '/') 
--select TOP 1 @seedNumber= items from #tbl ORDER BY id DESC
--drop table #tbl
 
--CREATE table #tbl1 (items varchar(max),id int)
--Insert into  #tbl1
--SELECT items, ROW_NUMBER() OVER (ORDER BY items asc) FROM [dbo].[Split] (@seedNumber, ' ') 
--select TOP 1 @output= items from #tbl1 ORDER BY id 
--drop table #tbl1  
--select @output

--END


GO
/****** Object:  StoredProcedure [dbo].[sp_EslForwardingNoteProc]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_EslForwardingNoteProc]
@batchId int = null,
@FnId int = null,
@atNoRef varchar(500) = null,
@forwardingNoteNumber varchar(500) = null,
@forwardNoteDate datetime = null,
@officerDesignation varchar(100) = null,
@officerPostalAddress varchar(700) = null,
@addressee varchar(700) = null,
@nomenStore varchar(200) = null,
@containerType varchar(200) = null,
@sampleRefNumber varchar(500) = null,
@sampleIdentificationMarks varchar(200) = null,
@sampleQualtity decimal(13,3) = null,
@numberOfSamples int = null,
@sampleType varchar(200) = null,
@dispatchDate datetime = null,
@dispatchMethod varchar(500) = null,
@sampleDrawnDate datetime = null,
@drawerNameAndRank varchar(700) = null,
@quantityRepressntedBySample decimal(12,3) = null,
@intendedDestination varchar(700) = null,
@fillingDate datetime = null,
@iNoteNumber varchar(200) = null,
@iNoteDate datetime = null,
@previousTestReferences varchar(500) = null,
@tankNumber varchar(200) = null,
@containerMarkingDetails varchar(200) = null,
@tradeOwned varchar(100) = null,
@govtStock varchar(100) = null,
@tradeGovtAccepted varchar(100) = null,
@reasonForTest varchar(max) = null,
@governingSupply varchar(500)=null,
@actionName varchar(50)=null,
@isForwardingNoteActive int = null,
@NewEslDate datetime = null,
@ModifyDate datetime = null,
@PreviousEslDate datetime = null, 
@StartDate datetime=null,
@EndDate datetime = null,
@Status varchar(15) =null,
@Output int=nuLL output

AS 

BEGIN
	if(@actionName='InsertData')
	 begin
	INSERT INTO ForwardNoteMaster(batchId,
	forwardingNoteNumber,
	forwardNoteDate,
	officerDesignation,
	officerPostalAddress,
	addressee,
	atNoReferences,
	nomenStore,
	containerType,
	sampleRefNumber,
	sampleIdentificationMarks,
	sampleQualtity,
	numberOfSamples,
	sampleType,
	dispatchDate,
	dispatchMethod,
	sampleDrawnDate,
	drawerNameAndRank,
	quantityRepressntedBySample,
	intendedDestination,
	fillingDate,
	iNoteNumber,
	iNoteDate,
	previousTestReferences,
	tankNumber,
	containerMarkingDetails,
	tradeOwned,
	govtStock,
	tradeGovtAccepted,
	reasonForTest,
	governingSupply,
	isForwardingNoteActive,
	OldEslDate,
	EslModifyDate) 
	Values(@batchId,
	@forwardingNoteNumber,
	@forwardNoteDate,
	@officerDesignation,
	@officerPostalAddress,
	@addressee,
	@atNoRef,
	@nomenStore,
	@containerType,
	@sampleRefNumber,
	@sampleIdentificationMarks,
	CAST(@sampleQualtity as decimal(13,3)),
	@numberOfSamples,
	@sampleType,
	@dispatchDate,
	@dispatchMethod,
	@sampleDrawnDate,
	@drawerNameAndRank,
	CAST(@quantityRepressntedBySample as decimal(12,3)),
	@intendedDestination,
	@fillingDate,
	@iNoteNumber,
	@iNoteDate,
	@previousTestReferences,
	@tankNumber,
	@containerMarkingDetails,
	@tradeOwned,
	@govtStock,
	@tradeGovtAccepted,
	@reasonForTest,
	@governingSupply,
	@isForwardingNoteActive,
	@PreviousEslDate,
	@ModifyDate);
	set @Output =SCOPE_IDENTITY(); 
	return @Output
	 end

	if(@actionName='EslManageGridDisplay')
	begin
	Select f.batchId as batchId, b.Esl as EslDate, f.dispatchDate as dispatchDate, b.EXPDate as ExpDate, p.Product_Name as ProductName,
	p.IsProductStatus as Status, f.sampleType as sampleType, f.quantityRepressntedBySample as quantity
    From BatchMaster as b, StockMaster as s, ProductMaster as p, ForwardNoteMaster as f
    where b.StockId = s.SID AND s.ProductId = p.Product_ID And b.BID = f.batchId And f.isForwardingNoteActive= 1 
	end

	if(@actionName='FetchAllDetails')
	begin
	SELECT * FROM ForwardNoteMaster where batchId = @batchId And isForwardingNoteActive=1
	end

	if(@actionName='FitBatchEslDateAndStatus')
	 begin
		begin transaction
			begin try
				Update BatchMaster set IsBatchStatus='Fit', ModifiedOn=@ModifyDate, Esl=@NewEslDate where BID = @batchId;				
				Update ForwardNoteMaster set isForwardingNoteActive=0 where batchId = @batchId AND isForwardingNoteActive=1;
				set @Output = 1;
       		    commit transaction
			end try
			begin catch
			    set @Output = -1;
				ROLLBACK transaction;
			end catch
	 return @Output;
	end

	if(@actionName='UnfitBatchDateAndStatus')
	 begin
		begin transaction
			begin try
				Update BatchMaster set IsBatchStatus='UnFit', ModifiedOn=@ModifyDate where BID = @batchId;
				Update ForwardNoteMaster set isForwardingNoteActive=0 where batchId = @batchId  AND isForwardingNoteActive=1;
				set @Output = 1;
       		    commit transaction
			end try
			begin catch
			    set @Output = -1;
				ROLLBACK transaction;
			end catch
	 return @Output;
	end

    if(@actionName='SelectForwardNoteDetails')
    begin
    select bm.BatchNo as BatchNo,bm.MFGDate as MfgDate, bm.Esl as EslDate, bm.ModifiedOn as modiFyDate, bm.isBatchStatus as batchStatus,       
    (select sm.AddedOn from StockMaster as sm where sm.SID=bm.StockId) as ReceiptDate,
    (select sm.ATNo from StockMaster as sm where sm.SID=bm.StockId) as AtNo,
    (select sm.RecievedFrom from StockMaster as sm where sm.SID=bm.StockId) as SupplySource,
    (select sm.PackagingMaterialShape from StockMaster as sm where sm.SID=bm.StockId) as Shape,
    (select sm.PackagingMaterialSize from StockMaster as sm where sm.SID=bm.StockId) as Size,   
    (select pm.Product_Name From ProductMaster as pm where pm.Product_ID = 
    (select sm.ProductId From StockMaster as sm, BatchMaster as bm where sm.SID = bm.StockId and bm.BID = fn.batchId))  as ProductName, fn.*       
    From BatchMaster as bm, ForwardNoteMaster as fn
	where bm.BID = fn.batchId And fn.Id = @FnId
	end

	if(@actionName='FilterbyDateAndStatus')
    begin
	Select f.Id as FnId, f.batchId as batchId, b.Esl as CurEsl, b.BatchNo as BatchNumber, p.Product_Name as ProductName, c.Type as Category,
	b.IsBatchStatus as batchStatus, f.OldEslDate as PreEsl, f.EslModifyDate as ModDate, f.forwardingNoteNumber as FnNumber
    From BatchMaster as b, StockMaster as s, ProductMaster as p, ForwardNoteMaster as f, CategoryType as c
    where b.StockId = s.SID AND s.ProductId = p.Product_ID And c.ID = p.Category_Id And b.BID = f.batchId And f.isForwardingNoteActive=0 
	And b.IsBatchStatus= @Status And f.EslModifyDate between @StartDate AND @EndDate
	end
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Gat]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
-- Author:  <Author,,Name>          
-- Create date: <Create Date,,>          
-- Description: <Description,,>          
-- =============================================          
CREATE PROCEDURE [dbo].[sp_Gat]   -- 'Selectfromto'  ,'2/26/2015 12:00:00 AM','2/26/2015 12:00:00 AM'     
@Id int = null,          
@IsLoadIn bit = null,          
@Recievedfrom varchar(50)=null,          
@vehbano varchar(50)=null,          
@franchiseeno varchar(50)= null,          
@ArmyNo varchar(50)= null,          
@rank varchar(50)= null,          
@name varchar(50)= null,           
@timein datetime = null,          
@typeofvehicle varchar(50) = null,          
@unitQuantityTypeId varchar(50)= null,          
@loadin varchar(50) = null,           
@IdtId varchar(50) = null,          
@timeout datetime = null,          
@loadout varchar(50) = null,          
@stationDepuID varchar(50) = null,          
@stationUnitId varchar(50)= null,          
@fuelintankIn varchar(50)= null,          
@fuelintankOut varchar(50)= null,          
@AddedBy int = null,          
@AddedOn datetime= null,          
@ModifiedBy int = null,          
@ModifiedOn datetime = null,          
@IsActive bit = null,          
@Action varchar(20),      
@from datetime=null,      
@to datetime=null        
AS          
BEGIN          
           
            
  If(@Action ='Insert')          
  begin          
  INSERT INTO GatInOut ([IsLoadIn],[vehbano],[franchiseeno],[ArmyNo],[rank],[name],[timein],[typeofvehicle]          
           ,[unitQuantityTypeId],[IdtId] ,[timeout] ,[loadout] ,[stationDepuID],[stationUnitId] ,[fuelintankIn]          
           ,[fuelintankOut] ,[AddedBy],[AddedOn],ModifiedBy,ModifiedOn,[IsActive])          
     VALUES (@IsLoadIn , @vehbano,@franchiseeno,@ArmyNo,@rank,@name,@timein,@typeofvehicle,@unitQuantityTypeId,          
           @IdtId ,@timeout, @loadout, @stationDepuID, @stationUnitId, @fuelintankIn,@fuelintankOut,@AddedBy,           
            GETDATE(),@ModifiedBy,GETDATE(),@IsActive)          
  SELECT @@IDENTITY        
  end               
         if(@Action='InsertionByGateIn')        
         begin        
         INSERT INTO GatInOut ([IsLoadIn],[Recievedfrom],[vehbano],[franchiseeno],[ArmyNo],[rank],[name],[timein],[typeofvehicle]          
           ,[unitQuantityTypeId],[loadin],[IdtId] ,[timeout] ,[stationDepuID],[stationUnitId] ,[fuelintankIn]          
           ,[fuelintankOut] ,[AddedBy],[AddedOn],ModifiedBy,ModifiedOn,[IsActive])          
     VALUES (@IsLoadIn ,@Recievedfrom, @vehbano,@franchiseeno,@ArmyNo,@rank,@name,@timein,@typeofvehicle,@unitQuantityTypeId,          
           @loadin,@IdtId ,@timeout,@stationDepuID, @stationUnitId, @fuelintankIn,@fuelintankOut,@AddedBy,           
            GETDATE(),@ModifiedBy,GETDATE(),@IsActive)          
  SELECT @@IDENTITY        
         end        
                 
                 
                      
     if(@Action = 'Update')            
      begin          
      UPDATE  GatInOut SET [IsLoadIn] = @IsLoadIn, vehbano = @vehbano, franchiseeno = @franchiseeno,          
      ArmyNo = @ArmyNo,rank = @rank, name = @name, timein = @timein,typeofvehicle = @typeofvehicle, unitQuantityTypeId = @unitQuantityTypeId,           
            
      IdtId = @IdtId, timeout = @timeout,loadout = @loadout,stationDepuID = @stationDepuID, stationUnitId = @stationUnitId,fuelintankIn = @fuelintankIn,          
      fuelintankOut = @fuelintankOut, ModifiedBy = @ModifiedBy,ModifiedOn = @ModifiedOn where Id = @Id          
      end           
              
      if(@Action='UpdateByGateIn')            
      begin        
       UPDATE  GatInOut SET [IsLoadIn] = @IsLoadIn,Recievedfrom=@Recievedfrom, vehbano = @vehbano, franchiseeno = @franchiseeno,          
      ArmyNo = @ArmyNo,rank = @rank, name = @name, timein = @timein,typeofvehicle = @typeofvehicle, unitQuantityTypeId = @unitQuantityTypeId,           
      loadin = @loadin,           
      IdtId = @IdtId, timeout = @timeout,stationDepuID = @stationDepuID, stationUnitId = @stationUnitId,fuelintankIn = @fuelintankIn,          
      fuelintankOut = @fuelintankOut, ModifiedBy = @ModifiedBy,ModifiedOn = @ModifiedOn where Id = @Id          
      end         
                   
      if(@Action = 'Inactive')          
      begin          
      Update GatInOut set IsActive = 'false' where Id=@Id          
      end           
                      
                      
      if(@Action = 'Selectall')          
      begin          
      Select *,(Select Depu_Name from DepuMaster where  Depu_Id=GatInout.stationDepuID) as DEPUNAME from GatInout    
          
       where IsActive ='true'    order by Id desc       
      end                 
                
      if(@Action = '')          
      begin          
      Select * from GatInout where IsActive ='true' and Id = @Id          
          
       end          
                
      if(@Action = 'Selectfromto')        
      begin      
     if((CONVERT(DATE,@from))=(CONVERT(DATE,@to)))    
     begin   
   Select * from GatInout where IsActive ='1' and CONVERT(date,AddedOn) = CONVERT(date,@from)  order by Id desc   
     end    
  else    
    begin    
	   Select * from GatInout where IsActive ='1' and  CONVERT(date,AddedOn)>=CONVERT(date,@from) and CONVERT(date,AddedOn)<= CONVERT(date,@to)   
	   order by Id desc 
    end    
      end      
        
       if(@Action = 'Selectallfromto')        
      begin      
	Select * from GatInout where IsActive ='1'  order by Id desc
      end                
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GateInOut]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GateInOut]    
 @Id int  =null       
,@vehbano varchar(50) =null         
,@franchiseeno varchar(50)   =null     
,@ArmyNo varchar(50) =null    
,@rank varchar(50) =null    
,@name varchar(50) =null    
,@timein datetime =null    
,@typeofvehicle varchar(50) =null    
,@unitQuantityTypeId int =null    
,@loadin varchar(50) =null    
,@IdtId int =null    
,@timeout datetime =null    
,@loadout varchar(50) =null    
,@stationDepuID int =null    
,@stationUnitId int=null    
,@fuelintankIn  varchar(50) =null    
,@fuelintankOut  varchar(50) =null    
,@AddedBy int=null    
,@AddedOn datetime =null    
,@ModifiedBy int=null    
,@ModifiedOn int=null    
,@IsActive bit=null    
,@Action varchar(100)=null       
,@Output int=null out       
AS    
BEGIN    
 IF(@Action='insertIntoGateInOut')        
  begin       
  insert into dbo.GateInout(vehbano,franchiseeno,ArmyNo,rank,name,timein,typeofvehicle,unitQuantityTypeId,loadin,    
  IdtId,timeout,loadout,stationDepuID,stationUnitId,fuelintankIn,fuelintankOut,AddedBy,AddedOn,ModifiedBy,ModifiedOn,IsActive)    
     
  values(@vehbano,@franchiseeno,@ArmyNo,@rank,@name,@timein,@typeofvehicle,@unitQuantityTypeId,@loadin,    
  @IdtId,@timeout,@loadout,@stationDepuID,@stationUnitId,@fuelintankIn,@fuelintankOut,@AddedBy,GETDATE(),@ModifiedBy,GETDATE(),@IsActive)    
     
   set @Output=@@IDENTITY  
     
   update IDT set IsGateOut=1 where Id=@IdtId  
     
   return @Output  
  end     
      
  if(@Action='UpdateInGateInOut')    
  begin    
  update dbo.GateInout set vehbano=@vehbano,franchiseeno=@franchiseeno,ArmyNo=@ArmyNo,rank=@rank,name=@name,timein=@timein,    
  typeofvehicle=@typeofvehicle,unitQuantityTypeId=@unitQuantityTypeId,loadin=@loadin,IdtId=@IdtId,timeout=@timeout,loadout=@loadout,    
  stationDepuID=@stationDepuID,stationUnitId=@stationUnitId,fuelintankIn=@fuelintankIn,fuelintankOut=@fuelintankOut,ModifiedBy=@ModifiedBy,ModifiedOn=@ModifiedOn,IsActive=@IsActive where Id=@Id    
  end    
      
 if(@Action='InActiveGateInOut')      
  begin      
   Update dbo.GateInout set IsActive =0 where Id=@Id      
  end      
      
  if(@Action='SelectAll')    
  begin    
  select * from dbo.GateInout WHERE IsActive=1     
  end    
      
      
  if(@Action='SelectId')    
  begin    
  select * from dbo.GateInout where Id=@Id     
  end    
   if(@Action='SelectGateOut')    
  begin    
	SELECT   
	(select IndentName From IDT where Id=iv.IdtId) as IndentName,* FROM IssueVoucher AS iv  
	inner join IDT as id on id.Id=iv.IdtId  
	INNER JOIN StockTransfer as st on iv.IdtId=st.IndentId  
	WHERE iv.IdtId=IdtId and id.IsActive=1 and id.IsApproved=1 and id.IsIssueVoucherId=1 and id.IsGateOut is null   
     
  end    
    
    if(@Action='SelectallGate')    
  begin   
 -- select   
 --(select QuantityType From QuantityType where QuantityType.Id=gat.unitQuantityTypeId) as 'unit',  
 --(select IDT.IndentName From IDT where IDT.Id=gat.IdtId) as 'irno',  
 --(select dp.Depu_Name From DepuMaster as dp where dp.Depu_Id=st.DepuMasterId) as 'depuname',  
 --(select um.Unit_Name From UnitMaster as um where um.Unit_Id=st.UnitMasterId) as 'unitname',  
 --* From GateInout as gat  
 -- inner join StockTransfer as st on gat.IsActive=1 
 
 select  
 (select QuantityType From QuantityType where QuantityType.Id=gat.unitQuantityTypeId) as 'unit',  
 (select IDT.IndentName From IDT where IDT.Id=gat.IdtId) as 'irno',  
 (select dp.Depu_Name From DepuMaster as dp where dp.Depu_Id=gat.stationDepuID) as 'depuname',  
 (select um.Unit_Name From UnitMaster as um where um.Unit_Id=gat.stationUnitId) as 'unitname', 
 * From GateInout as gat  
  where gat.IsActive=1    
   
  end  
    
END


GO
/****** Object:  StoredProcedure [dbo].[sp_IssueVoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_IssueVoucher]            
 @Id int=null,
 @ivNo varchar(50)='',               
 @IdtId int=null,              
 @ToDepuId int=null,              
 @ToUnitId int=null,            
 @VechileNo varchar(50)=null,            
 @Authority varchar(50)=null,            
 @Through varchar(100)=null,            
 @IsActive bit =null,              
 @AddedOn datetime=null,              
 @AddedBy int=null,              
 @ModifiedOn datetime=null,              
 @ModifiedBy int=null,              
 @Action varchar(100)=null,               
 @Output int=null output,            
 @from datetime=NULL,    
 @to datetime=null            
AS            
BEGIN            
 if(@Action = 'InsertIssueVoucher')                          
 begin             
       
                    
 insert into dbo.IssueVoucher(IdtId,ToDepuId,ToUnitId,VechileNo,Authority,Through                
 ,IsActive,AddedBy,AddedOn,ModifiedBy,ModifiedOn)values      
 ( @IdtId,@ToDepuId,@ToUnitId,@VechileNo,@Authority,@Through,@IsActive,@AddedBy,GETDATE(),@ModifiedBy,GETDATE())       
       
 set @Output=@@identity       
   update IDT set IsIssueVoucherId=1,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() where Id=@IdtId       
       
 return @Output         
             
  end               
              
  if(@Action='UpdateIssueVoucher')            
  begin            
  update dbo.IssueVoucher set IdtId=@IdtId,ToDepuId=@ToDepuId,ToUnitId=@ToUnitId,VechileNo=@VechileNo,            
  Authority=@Authority,Through=@Through,IsActive=@IsActive,AddedBy=@AddedBy where Id=@Id            
  end            
              
  if(@Action='InActiveIssueVoucher')            
  begin            
  Update IssueVoucher set IsActive =0 where Id=@Id             
  end            
              
  if(@Action='SelectAll')            
  begin            
   select * from IssueVoucher where IsActive=1           
              
  end            
                
    IF(@Action='SelectStockTransferDetailIndentWise')          
    begin          
		 select idt.Id as indentid,        
	  ( select Product_Name from ProductMaster as pm where pm.Product_ID=st.ProductMasterId) as productname        
	  ,st.ProductMasterId,        
	   (select qt.QuantityType from StockMaster as sm         
		inner join QuantityType as qt on qt.Id=convert(varchar,sm.QuantityType)  --convert(int,sm.QuantityType)      
		where sm.BID=bm.BID) as AuUnitName ,        
		st.QtyIssued as qty, bm.MFGDate as'domdate',bm.EXPDate 'esldate',* From IDT as idt           
	   inner join StockTransfer as st on st.IndentId=idt.Id          
	   --inner join ProductMaster as pm on st.ProductMasterId=pm.Product_ID          
	   inner join BatchMaster as bm on bm.BID=st.BatchMasterId        
	   where idt.Id=@IdtId and idt.IsActive=1 and idt.IsApproved=1          
		and idt.IsIssueVoucherId is null           
  end          
              
   if(@Action='SelectById')          
   begin          
   select * from IssueVoucher where IsActive=1 and Id=@Id          
   end      
       
    if(@Action = 'Selectfromto')            
      begin          
     if((CONVERT(DATE,@from))=(CONVERT(DATE,@to)))        
     begin       
   select     
   (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=IssueVoucher.ToDepuId) as DepuName,    
    (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=IssueVoucher.ToUnitId) as UnitName,    
   	* from IssueVoucher 
		inner join IDT as idt on idt.Id=IssueVoucher.IdtId
		where IssueVoucher.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1 
      and CONVERT(date,IssueVoucher.AddedOn) = CONVERT(date,@from)  order by IssueVoucher.Id desc       
     end        
  else        
    begin        
   select     
   (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=IssueVoucher.ToDepuId) as DepuName,    
    (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=IssueVoucher.ToUnitId) as UnitName,    
   * from IssueVoucher 
   inner join IDT as idt on idt.Id=IssueVoucher.IdtId
		where IssueVoucher.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1 
		 and  CONVERT(date,IssueVoucher.AddedOn)>=CONVERT(date,@from) and CONVERT(date,IssueVoucher.AddedOn)<= CONVERT(date,@to)       
   order by IssueVoucher.Id desc     
    end        
      end          
               
   if(@Action='SelectIssuedall')          
   begin          
		 select     
		(SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=IssueVoucher.ToDepuId) as DepuName,    
	  (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=IssueVoucher.ToUnitId) as UnitName,    
		* from IssueVoucher 
		inner join IDT as idt on idt.Id=IssueVoucher.IdtId
		where IssueVoucher.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1 
		ORDER BY IssueVoucher.Id DESC   
   end      
        
     if(@Action='SelectIssuedetailview')          
   begin          
   select     
     (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=iv.ToDepuId) as DepuName,    
   (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=iv.ToUnitId) as UnitName,    
     * from IssueVoucher as iv where IsActive=1 and Id=@Id ORDER BY Id DESC   
       
     set @IdtId=(select IdtId From IssueVoucher where Id=@Id)  
       
         select idt.Id as indentid,         
     ( select Product_Name from ProductMaster as pm where pm.Product_ID=st.ProductMasterId) as productname        
     ,st.ProductMasterId,        
      (select qt.QuantityType from StockMaster as sm         
    inner join QuantityType as qt on qt.Id=convert(varchar,sm.QuantityType)  --convert(int,sm.QuantityType)      
    where sm.BID=bm.BID) as AuUnitName ,        
    st.QtyIssued as qty, bm.MFGDate as'domdate',bm.EXPDate 'esldate',* From IDT as idt           
      inner join StockTransfer as st on st.IndentId=idt.Id          
      --inner join ProductMaster as pm on st.ProductMasterId=pm.Product_ID          
      inner join BatchMaster as bm on bm.BID=st.BatchMasterId     
      where idt.Id=@IdtId and idt.IsActive=1 and idt.IsApproved=1          
    and idt.IsIssueVoucherId =1     
      
   end  
    if(@Action='IssueVoucherPrintDetail')          
   begin 
    set @ivNo=(select IssueVoucherName From tblIssueVoucherDetail where Id=@Id)
     select * from tblIssueVoucherVehicleDetail ivD 
     inner join ProductMaster as pm on ivD.ProductId=pm.Product_ID   
     inner join BatchMaster as bm on bm.BID=ivD.BID           
     inner join tbl_vechileMaster v on v.Id=ivD.VehicleId
     inner join CategoryMaster cat on cat.ID=ivD.Cat_ID
     inner join tbl_IssueOrder iod on iod.ID=ivD.issueorderID        
     where ivD.Active=1 and ivD.IssueVoucherId=@ivNo
            
   end           
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ManageTallySheet]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ManageTallySheet]          
 @Id int=null,          
 @IdtId int=null,          
 @DepuIdFrom int=null,          
 @UnitIdFrom int=null,          
 @ToDepuId int=null,          
 @ToUnitId int=null,          
 @Authority varchar(50)=null,          
 @Through varchar(50)=null,          
 @VehBaNo varchar(50)=null,          
 @AddedBy int=null,          
 @AddedOn datetime=null,          
 @ModifiedBy int=null,          
 @ModifiedOn DATETIME=null,          
 @IsActive bit=null,          
 @Action varchar(100)=null,               
 @Output int=null output,           
 @from datetime=NULL,    
 @to datetime=null                
           
AS          
BEGIN          
 if(@Action='InsertIntoTallySheet')          
 begin        
         
 insert into TallySheet(IdtId,DepuIdFrom,ToDepuId,ToUnitId,Authority,Through,VehBaNo,AddedBy,AddedOn,ModifiedBy,ModifiedOn,IsActive)          
 values(@IdtId,@DepuIdFrom,@ToDepuId,@ToUnitId,@Authority,@Through,@VehBaNo,@AddedBy,GETDATE(),@ModifiedBy,GETDATE(),@IsActive)          
 set @Output =(@@IDENTITY)         
         
 update IDT set IsTallySheetId=1,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() where Id=@IdtId        
     return @Output        
             
 end          
           
           
 if(@Action='UpdateTallySheet')          
 begin          
 update TallySheet set IdtId=@IdtId,DepuIdFrom=@DepuIdFrom,UnitIdFrom=@UnitIdFrom,ToDepuId=@ToDepuId,ToUnitId=@ToUnitId,Authority=@Authority,          
 Through=@Through,VehBaNo=@VehBaNo,ModifiedBy=@ModifiedBy,ModifiedOn=@ModifiedOn,IsActive=@IsActive where Id=@Id          
 end          
           
           
 if(@Action='InActiveTallySheet')          
 begin          
 update TallySheet set IsActive=0 where Id=@Id          
 end          
     
  if(@Action = 'Selectfromto')            
      begin          
     if((CONVERT(DATE,@from))=(CONVERT(DATE,@to)))        
     begin       
    select     
  (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=TallySheet.ToDepuId) as DepuName,    
  (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=TallySheet.ToUnitId) as UnitName,    
    * fROM TallySheet
       inner join IDT as idt on idt.Id=TallySheet.IdtId
    where TallySheet.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1  
      and CONVERT(date,TallySheet.AddedOn) = CONVERT(date,@from)  order by TallySheet.Id desc       
     end        
  else        
    begin        
   select     
 (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=TallySheet.ToDepuId) as DepuName,    
 (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=TallySheet.ToUnitId) as UnitName,    
   * fROM TallySheet
     inner join IDT as idt on idt.Id=TallySheet.IdtId
    where TallySheet.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1  
    and  CONVERT(date,TallySheet.AddedOn)>=CONVERT(date,@from) and CONVERT(date,TallySheet.AddedOn)<= CONVERT(date,@to)       
   order by TallySheet.Id desc     
    end        
      end        
               
  if(@Action='selecttallyall')          
 begin          
    select     
 (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=TallySheet.ToDepuId) as DepuName,    
 (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=TallySheet.ToUnitId) as UnitName,    
   * fROM TallySheet 
     inner join IDT as idt on idt.Id=TallySheet.IdtId
    where TallySheet.IsActive=1 and idt.IsApproved=1 and IsIssueVoucherId=1  
     ORDER BY TallySheet.Id DESC 
          
 end       
    
   if(@Action='selecttallydetailview')          
 begin          
    select     
   (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=TallySheet.DepuIdFrom) as DepuFROMName,   
  (SELECT du.Depu_Name fROM DepuMaster AS du where du.Depu_Id=TallySheet.ToDepuId) as DepuName,    
  (SELECT ut.Unit_Name fROM UnitMaster AS ut where ut.Unit_Id=TallySheet.ToUnitId) as UnitName,    
    * fROM TallySheet where IsActive=1 and Id=@Id order by Id desc    
     
   set @IdtId=(select IdtId from TallySheet where Id=@Id)   
     
         select idt.Id as indentid,          
  ( select Product_Name from ProductMaster as pm where pm.Product_ID=st.ProductMasterId) as productname          
  ,st.ProductMasterId,          
   (select qt.QuantityType from StockMaster as sm           
    inner join QuantityType as qt on qt.Id=convert(varchar,sm.QuantityType)     --convert(int,sm.QuantityType)      
    where sm.BID=bm.BID) as AuUnitName ,          
    st.QtyIssued as qty, bm.MFGDate as'domdate',bm.EXPDate 'esldate',* From IDT as idt             
   inner join StockTransfer as st on st.IndentId=idt.Id            
   --inner join ProductMaster as pm on st.ProductMasterId=pm.Product_ID            
   inner join BatchMaster as bm on bm.BID=st.BatchMasterId          
   where idt.Id=@IdtId and idt.IsActive=1 and idt.IsApproved=1      
    and idt.IsTallySheetId =1       
      
 end   
     
END


GO
/****** Object:  StoredProcedure [dbo].[sp_OrderType]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrderType]
	@ID int=null,
	@Name Varchar(50)=null,
	 @AddedBy int=null,  
  @AddedOn datetime=null,  
  @IsActive bit =null,         
  @Action varchar(100)=null,  
  @Output int=NULL output  
	
AS
BEGIN
	if(@Action='InsertOrder')
	begin
	insert into TypeOfOrder(Name,IsActive,AddedBy,AddedOn)values        
                      (@Name,@IsActive,@AddedBy,GETDATE());     
                       set @Output =SCOPE_IDENTITY();  
	end
	
	if(@Action='UpdateOrder')
	begin
	Update TypeOfOrder set Name=@Name,IsActive=@IsActive where ID=@ID
	end
	
	if(@Action='InActive')
	begin
	Update TypeOfOrder set IsActive =0 where ID=@ID  
	end
	
	if(@Action='SelectOrder')
	begin
	select * from TypeOfOrder where ID=@ID and IsActive=1
	end
END


GO
/****** Object:  StoredProcedure [dbo].[sp_StockTransfer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_StockTransfer]               
  @ID int=null,                
  @DepuMasterId int=null,               
  @IsUnit bit=0,              
  @UnitMasterId int=null,              
  @CategoryMasterId int=null,              
  @ProductMasterId int=null,               
  @TypeOfOrderId int=null,              
  @QtyIssued int=null,              
  @AddedBy int=null,              
  @AddedOn datetime=null,              
    @IsActive bit =null,                     
   @Action varchar(100)=null,              
   @Depu_Id int=null,              
   @Product_Id int=null,              
   @Category_Id int=null,              
 @CategoryTypeId int=null,              
 @Category_TypeId int=null,          
 @IndentId int =null,          
 @XMLData XML=NULL ,          
 @StockQty float=null,  
 @IssueQty float=NULL,      
 @ModifiedBy int =null,
 @BID INT=NULL,        
  @Output int=0 output               
AS              
BEGIN              
 if(@Action = 'InsertStockTransfer')                    
 begin                  
                                        
         begin              
  update ProductMaster set StockQty=StockQty-@QtyIssued where Product_ID=@ProductMasterId              
  --select @id               
  end              
                     
     return @Output                                  
                                     
 end             
         
         
 if(@Action = 'InsertStock')                    
 begin                    
 insert into StockTransfer(DepuMasterId,IsUnit,UnitMasterId,CategoryTypeId,CategoryMasterId,ProductMasterId          
 ,BatchMasterId,TypeOfOrderId,IndentId,QtyIssued,IsActive,AddedBy,AddedOn)           
           
 (SELECT @DepuMasterId,@IsUnit,@UnitMasterId,          
 CONVERT(INT,(CAST(Colx.query('data(CategoryTypeId)') as VARCHAR(10)))) as CategoryTypeId,          
  CONVERT(INT,(CAST(Colx.query('data(CategoryMasterId)') as VARCHAR(10)))) as CategoryMasterId,          
   CONVERT(INT,(CAST(Colx.query('data(ProductMasterId)') as VARCHAR(10)))) as ProductMasterId,   
   CONVERT(INT,(CAST(Colx.query('data(BatchMasterId)') as VARCHAR(10)))) as BatchMasterId,  
  --cast(Colx.query('data(CategoryMasterId)') as int) as CategoryMasterId ,          
  -- cast(Colx.query('data(ProductMasterId)') as int) as CategoryMasterId ,          
   @TypeOfOrderId,@IndentId,          
      CONVERT(INT,(CAST(Colx.query('data(QtyIssued)') as VARCHAR(15)))) as QtyIssued,          
    --cast(Colx.query('data(QtyIssued)') as decimal) as QtyIssued,          
    @IsActive,@AddedBy,getdate()           
    from @XMLData.nodes('DocumentElement/xmltable') as Tabx(Colx))          
                  
   --(@DepuMasterId,@IsUnit,@UnitMasterId,@CategoryTypeId,@CategoryMasterId,@ProductMasterId,@TypeOfOrderId,@QtyIssued,@IsActive,@AddedBy,GETDATE());                 
    -- set @Output =SCOPE_IDENTITY();                 
         --SELECT * fROM  ProductMaster         
                 
       --UPDATE ProductMaster         
       --SET StockQty=StockQty- CONVERT(numeric,(CAST(Colx.query('data(QtyIssued)') as VARCHAR(10))))         
       ----WHERE Product_ID IN (CONVERT(INT,(CAST(Colx.query('data(ProductMasterId)') as VARCHAR(10)))))        
       --from @XMLData.nodes('DocumentElement/xmltable') with (ProductMasterId  int,) as Tabx(Colx)        
                 
       --  update ProductMaster set StockQty=StockQty-@QtyIssued        
       --   where Product_ID=        
  --       begin              
  --update ProductMaster set StockQty=StockQty-@QtyIssued where Product_ID=@ProductMasterId              
  ----select @id               
  --end              
                     
  --   return @Output                                  
                                     
 end            
         
  if(@Action='UpdateStockinproduct')              
 begin              
  --update ProductMaster set StockQty=@StockQty,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE()     
  -- where Product_ID=@ProductMasterId
   
   UPDATE StockMaster SET IssueQty=IssueQty-@IssueQty,Quantity=Quantity-@IssueQty
   ,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE()
     WHERE BID=@BID    
     
     UPDATE ProductMaster SET StockQty=StockQty-@IssueQty,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() 
        WHERE Product_ID=@ProductMasterId
 end         
         
               
 if(@Action='UpdateStockTransfer')              
 begin              
  update StockTransfer set DepuMasterId=@DepuMasterId,IsUnit=@IsUnit,UnitMasterId=@UnitMasterId,              
  CategoryMasterId=@CategoryMasterId,ProductMasterId=@ProductMasterId,QtyIssued=@QtyIssued,IsActive=@IsActive where  ID=@ID             
 end              
               
 if(@Action='InActive')              
 begin              
 Update StockTransfer set IsActive =0 where ID=@ID              
 end              
               
 if(@Action='SelectStock')              
 begin              
 select * from StockTransfer where ID=@ID              
  end              
                
  if(@Action='SelectDepu')              
  begin              
  select * from DepuMaster where Depu_Id=@DepuMasterId and IsActive=1              
  end              
                
   if(@Action='SelectDepot')              
  begin              
  select * from DepuMaster where  IsActive=1              
  end            
                
  if(@Action='SelectUnit')              
  begin              
  select * from UnitMaster where IsActive=1              
  end              
                
  if(@Action='SelectCategory')              
  begin              
  if (@Category_TypeId=0)            
  begin            
    select * from CategoryMaster             
  end            
 else            
  begin            
  select * from CategoryMaster where Category_TypeId=@Category_TypeId and IsActive=1              
 end            
  end              
                
  if(@Action='SelectProduct')              
  begin              
  select * from ProductMaster               
  end              
                
  if(@Action='SelectOrder')              
  begin              
  select * from TypeOfOrder where ID=@ID and IsActive=1              
  end              
                
   if(@Action = 'GetUnitByDID')                  
  begin                  
  select * from UnitMaster where Depu_Id=@Depu_Id and IsActive=1               
 -- select * from CategoryMaster where IsActive=1                  
  end                  
                
  if(@Action='GetProductByID')              
  begin              
  select * from ProductMaster where Category_Id=@Category_Id and IsActive=1              
  end              
                
  if(@Action='GetCategoryByType')              
  begin              
 select * from CategoryType where IsActive=1              
  end              
                
   if(@Action='checkquantity')              
  begin              
  select StockQty from ProductMaster where Product_ID=@Product_ID              
                 
  end              
                
  if(@Action = 'InsertStockTransferToDepo')                    
 begin                    
 insert into StockTransfer(DepuMasterId,IsUnit,CategoryTypeId,CategoryMasterId,ProductMasterId,TypeOfOrderId,QtyIssued,IsActive,AddedBy,AddedOn)values                    
                      (@DepuMasterId,@IsUnit,@CategoryTypeId,@CategoryMasterId,@ProductMasterId,@TypeOfOrderId,@QtyIssued,@IsActive,@AddedBy,GETDATE());                 
                       set @Output =SCOPE_IDENTITY();                 
 end          
     
 IF(@Action='SelectQuantityType')    
 begin    
  select * from Quantitytype WHERE ISACTIVE=1    
 end        
                
END


GO
/****** Object:  StoredProcedure [dbo].[spcategorymaster]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Ravi>    
-- Create date: <Create 03-12-2014,,>    
-- Description: <Insertion,>    
-- =============================================    
    
    
    
CREATE PROCEDURE [dbo].[spcategorymaster]    
 -- Add the parameters for the stored procedure here    
 @ID int=0,     
     
 @Category_Code varchar(50)=null,    
 @Category_Name varchar(50)=null,    
 @Category_TypeId int=null,    
 @Category_Desc varchar(500)=null,    
 @ParentCategory_Id int=null,    
 @IsActive bit =null,    
 @AddedOn datetime=null,    
 @AddedBy int=null,    
 @ModifiedOn datetime=null,    
 @ModifiedBy int=null,    
 @Action varchar(100)=null,     
 @Output int=null output    
     
     
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 if(@Action = 'Insert')    
 begin    
	 if (@ParentCategory_Id is null)
		begin
			 if exists(select * From CategoryMaster where Category_TypeId=@Category_TypeId and IsActive=1 and (ltrim(rtrim(lower((Category_Name))))) = ((ltrim(rtrim(lower(@Category_Name))))) 
   and ParentCategory_Id is null)
   --and ParentCategory_Id = case when @ParentCategory_Id IS NULL  then NULL else @ParentCategory_Id  end)
    begin
	   set @Output =-1    
	   return @Output
    end
	else
	begin
		insert into CategoryMaster(Category_Code,Category_Name,Category_TypeId,Category_Desc,ParentCategory_Id,IsActive,AddedBy,AddedOn)values    
	   (@Category_Code,@Category_Name,@Category_TypeId,@Category_Desc,@ParentCategory_Id,@IsActive,@AddedBy,GETDATE());    
	   set @Output =SCOPE_IDENTITY();    
	   return @Output   
	end
		end
	else
		begin
			if exists(select * From CategoryMaster where Category_TypeId=@Category_TypeId and (ltrim(rtrim(lower((Category_Name))))) = ((ltrim(rtrim(lower(@Category_Name))))) 
		   and ParentCategory_Id =@ParentCategory_Id)
		   --and ParentCategory_Id = case when @ParentCategory_Id IS NULL  then NULL else @ParentCategory_Id  end)
			begin
			   set @Output =-1    
			   return @Output
			end
			else
			begin
				insert into CategoryMaster(Category_Code,Category_Name,Category_TypeId,Category_Desc,ParentCategory_Id,IsActive,AddedBy,AddedOn)values    
			   (@Category_Code,@Category_Name,@Category_TypeId,@Category_Desc,@ParentCategory_Id,@IsActive,@AddedBy,GETDATE());    
			   set @Output =SCOPE_IDENTITY();    
			   return @Output   
			end
		end
  
 
   end    
   if(@Action = 'Griddisplay')    
  begin    
  --select TypeID=ct.ID,* from CategoryMaster cm   inner join CategoryType ct on ct.ID=cm.ID  where cm.IsActive=1   
    
  select *,(Select cp.Category_Name from CategoryMaster cp where cp.ID=cm.ParentCategory_Id) as Parent,  
  (select ct.Type from CategoryType ct where ct.ID=cm.Category_TypeId) as Type   
   from CategoryMaster cm     
      
  end    
      
   if(@Action='Update')    
   begin    
   
    if (@ParentCategory_Id is null)
       begin
			if exists(select * From CategoryMaster where Category_TypeId=@Category_TypeId and (ltrim(rtrim(lower((Category_Name))))) = ((ltrim(rtrim(lower(@Category_Name))))) and ParentCategory_Id is null and ID not in(@ID))
			begin
			   set @Output =-1    
			   return @Output
			end
			else
			 begin
				 update CategoryMaster set Category_Name=@Category_Name,Category_Desc=@Category_Desc,Category_TypeId=@Category_TypeId
				 ,ParentCategory_Id=@ParentCategory_Id,IsActive=@IsActive,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() 
				  where ID=@ID 
				  set @Output =@ID  
				   return @Output    
			 end
       end
     else
       begin
		   if exists(select * From CategoryMaster where Category_TypeId=@Category_TypeId and  (ltrim(rtrim(lower((Category_Name))))) = ((ltrim(rtrim(lower(@Category_Name))))) and ParentCategory_Id = @ParentCategory_Id and ID!=@ID)
			begin
			   set @Output =-1    
			   return @Output
			end
			else
			 begin
				 update CategoryMaster set Category_Name=@Category_Name,Category_Desc=@Category_Desc,Category_TypeId=@Category_TypeId
				 ,ParentCategory_Id=@ParentCategory_Id,IsActive=@IsActive,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() 
				  where ID=@ID 
					set @Output =@ID  
				   return @Output 
			 end
       end
   
 end    
  if(@Action='updateactive')    
   begin    
   update CategoryMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  ID=@ID    
 end    
     
  if(@Action = 'DropDisplay')    
  begin    
 select * from CategoryType   
 -- select * from CategoryMaster where IsActive=1    
  end    
     
     
END


GO
/****** Object:  StoredProcedure [dbo].[spcategorytype]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Ravi>  
-- Create date: <Create 03-12-2014,,>  
-- Description: <Insertion,>  
-- =============================================  
  
  
  
CREATE PROCEDURE [dbo].[spcategorytype]  
 -- Add the parameters for the stored procedure here  
 @ID int=null,   
 @Type varchar(50)=null,  
 @Description varchar(500)=null,  
 @IsActive bit =null,  
 @AddedOn datetime=null,  
 @AddedBy int=null,  
 @ModifiedOn datetime=null,  
 @ModifiedBy int=null,  
 @Action varchar(100)=null,   
 @Output int=null output,
 @chkIsActive bit=Null, 
 @chkType varchar(50)=null 
   
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 if(@Action = 'Insert')  
 begin 
	--select * from CategoryType
	if exists (Select * From CategoryType where (ltrim(rtrim(lower((Type))))) = ((ltrim(rtrim(lower(@Type))))))
	 begin
		 set @Output = -1  
		 return @Output  
	 end
	 else
	 begin
		 insert into CategoryType(Type,Description,IsActive,AddedBy,AddedOn)values  
		(@Type,@Description,@IsActive,@AddedBy,GETDATE());  
		 set @Output =SCOPE_IDENTITY();  
		 return @Output 
	 end
   end  
   if(@Action = 'Griddisplay')  
  begin  
  select * from CategoryType   
 -- select * from CategoryMaster where IsActive=1  
  end  
   if(@Action='Update')  
   begin  
     IF EXISTS(SELECT * FROM CategoryType WHERE ltrim(rtrim(lower((Type)))) = (ltrim(rtrim(lower(@Type)))) AND ID!=@ID)
		BEGIN
			   SET @Output=-1
			   RETURN @Output
		END
	ELSE
		BEGIN
			 update CategoryType set Type=@Type,Description=@Description,IsActive=@IsActive,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE() 
			 where  ID=@ID  
			 SET @Output=@ID
			 RETURN @Output
		END
  
 end  
  if(@Action='updateactive')  
   begin  
   update CategoryType set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  Id=@ID  
 end  
END


GO
/****** Object:  StoredProcedure [dbo].[spDepartment]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDepartment]
	@Action varchar(50)=null,
	@Id int=null,
	@DeptName varchar(50)=null,
	@DeptCode varchar(50)=null,
	@Description varchar(500)=null,
	@AddedOn datetime=null,
	@AddedBy int=null,
	@ModifiedOn datetime=null,
	@Modifiedby int=null,
	@IsActive int=null,
	@RoleID int=null,
	 @Output int=0 output  

AS
BEGIN
	
	 if(@Action = 'Insert')  
 begin  
 insert into DeptMaster(DeptName,DeptCode,Description,AddedOn,AddedBy,IsActive)values  
             (@DeptName,@DeptCode,@Description,getdate(),@AddedBy,@IsActive);  
 set @Output =SCOPE_IDENTITY();  
   return @Output  
   end  
   if(@Action = 'SelectAll')  
 begin  
 select * from DeptMaster 
   end 
    
   if(@Action = 'SelectActive')  
 begin  
 select Dept=DeptName+'('+DeptCode+') ',* from DeptMaster where IsActive=1
   end  
   
   if(@Action = 'Update')  
 begin  
 update  DeptMaster set DeptName=@DeptName,DeptCode=@DeptCode,Description=@Description,ModifiedOn=getdate(),Modifiedby=@Modifiedby,IsActive=@IsActive  
            where Id=@Id
   end 
    if(@Action = 'SelectByRoleID')  
 begin  
 select Id from DeptMaster where Id=(select DeptId from RoleMaster where Role_ID=@RoleID)
   end
     
END


GO
/****** Object:  StoredProcedure [dbo].[spDepu]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
         
        
          
    
         --    UnitName varchar(500)
 --   IDTICTAWS varchar(50)
  --  update DepuMaster set IDTICTAWS='IDT'   
 -- =============================================  
   
CREATE PROCEDURE [dbo].[spDepu]          
 -- Add the parameters for the stored procedure here          
 @Depu_Id int=null,          
 @Depu_Name varchar(50)=null,          
 @Depu_Location varchar(50)=null,          
 @IsActive bit =null,          
 @Depot_Code varchar(50)=null,          
 @IsParent bit=null,          
 @AddedOn datetime=null,          
 @AddedBy int=null,          
 @ModifiedOn datetime=null,          
 @ModifiedBy int=null,          
 @Action varchar(100)=null,           
 @Output int=nULL output,      
 @status varchar(20)=NULL ,         
 @uid int=Null,       
 @uidbool bit=Null   ,  
 @chkIsParent bit=Null,  
 @chkDepu_Name varchar(50)=null,  
 @CommandId int=null,       
 @FormationId int=null,    
 @Corp varchar(50)=null,   
 @DepotNo varchar(50)=null ,    
    @UnitName varchar(500)=null,   
 @IDT varchar(50)=null  ,
  @ICT varchar(50)=null ,  
   @AWS varchar(50)=null              
AS          
BEGIN          
 -- SET NOCOUNT ON added to prevent extra result sets from          
 -- interfering with SELECT statements.          
 if(@Action = 'Insert')          
 begin          
       
 if exists(select * From DepuMaster where (ltrim(rtrim(lower((Depu_Name)))) = (ltrim(rtrim(lower(@Depu_Name))))))      
  BEGIN      
    SET @Output=-1      
    return @Output         
  END      
  ELSE      
   BEGIN      
     if exists(select *  from DepuMaster where IsParent='1' and IsActive='1')      
      begin      
         IF(@IsParent='1')      
          begin      
               if(@status='pending')      
                 begin      
            SET @Output=-2      
            return @Output      
                 end      
                 else      
                  begin      
                 set @uid=(select Depu_Id from DepuMaster where IsParent='1' and IsActive='1')    
                  update DepuMaster set IsParent='0' where Depu_Id=@uid    
                     
      insert into DepuMaster(UnitName, IDT,ICT,AWS, Depu_Name,Depu_Location,Depot_Code,IsParent,IsActive,AddedOn,AddedBy ,FormationId,Corp  
           ,DepotNo)values          
     (@UnitName, @IDT,@ICT,@AWS, @Depu_Name,@Depu_Location,@Depot_Code,@IsParent,@IsActive,GETDATE(),@AddedBy,@FormationId,@Corp  
           ,@DepotNo);          
     set @Output =SCOPE_IDENTITY();          
     return @Output        
                end      
          end      
          else      
          begin      
    insert into DepuMaster(UnitName, IDT,ICT,AWS,Depu_Name,Depu_Location,Depot_Code,IsParent,IsActive,AddedOn,AddedBy,FormationId,Corp,DepotNo)values          
    (@UnitName, @IDT,@ICT,@AWS,@Depu_Name,@Depu_Location,@Depot_Code,@IsParent,@IsActive,GETDATE(),@AddedBy,@FormationId,@Corp  
           ,@DepotNo);           
    set @Output =SCOPE_IDENTITY();          
    return @Output        
          end      
      end      
      else      
      begin    
          
      insert into DepuMaster(UnitName, IDT,ICT,AWS,Depu_Name,Depu_Location,Depot_Code,IsParent,IsActive,AddedOn,AddedBy,FormationId,Corp  
           ,DepotNo)values          
    (@UnitName, @IDT,@ICT,@AWS,@Depu_Name,@Depu_Location,@Depot_Code,@IsParent,@IsActive,GETDATE(),@AddedBy,@FormationId,@Corp  
           ,@DepotNo);       
   set @Output =SCOPE_IDENTITY();          
   return @Output         
      end      
   END      
         
 --select COUNT(depu_id)from DepuMaster where Depu_Name='rhpd'      
      
   end          
   if(@Action = 'select')          
  begin          
  select (dm.idt+' '+dm.ict+' '+dm.aws) as IDTICTAWS ,dm.*,cm.Name as cmname,fm.name as fmname from DepuMaster dm      
    
  inner join formation fm on fm.id=dm.FormationId  
  inner join CommandMaster cm on cm.id = fm.CommandId  
 -- select * from CategoryMaster where IsActive=1          
  end          
      
   if(@Action = 'selectDATA')          
  begin          
  select *  from DepuMaster where IsParent='1' and IsActive='1'    
      
  select *  from DepuMaster where Depu_Id=@Depu_Id      
 -- select * from CategoryMaster where IsActive=1          
  end        
      
   if(@Action='Update')       
   begin              
  -- if exists(select * From DepuMaster where (ltrim(rtrim(lower((Depu_Name)))) = (ltrim(rtrim(lower(@Depu_Name))))) and Depu_Id!=@Depu_Id)      
  --BEGIN      
  --  SET @Output=-1      
  --  return @Output         
  --END    
  -- else    
  --begin    
  --  set @uidbool=(select IsParent from DepuMaster where Depu_Id=@Depu_Id)    
        
  --  if(@uidbool='true')    
  --   begin    
  -- update DepuMaster set Depu_Name=@Depu_Name,Depu_Location=@Depu_Location,IsParent=@IsParent,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy     
  --   where  Depu_Id=@Depu_Id      
  --   SET @Output=@Depu_Id    
  --   return @Output      
  --   end    
  --   else    update DepuMaster set IDTICTAWS='IDT'
  --   begin    
  --        if(@status='pending')      
  --               begin      
  --          SET @Output=-2      
  --          return @Output      
  --               end      
  --               else      
  --                begin      
  --               set @uid=(select Depu_Id from DepuMaster where IsParent='1' and IsActive='1')    
  --                update DepuMaster set IsParent='0' where Depu_Id=@uid    
                      
  --                update DepuMaster set Depu_Name=@Depu_Name,Depu_Location=@Depu_Location,IsParent=@IsParent,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy     
  --     where  Depu_Id=@Depu_Id      
  --     SET @Output=@Depu_Id    
  --     return @Output      
  --              end      
  --   end    
  --end      
    
  set @chkIsParent=(select IsParent From DepuMaster where Depu_Id=@Depu_Id)  
if (@chkIsParent='1')  
 begin  
  -- is parent is one  
  set @chkDepu_Name= (select Depu_Name From DepuMaster where ltrim(rtrim(lower((Depu_Name)))) =(ltrim(rtrim(lower(@Depu_Name))))  AND Depu_Id!=@Depu_Id)   
  if(ltrim(rtrim(lower((@chkDepu_Name)))) = (ltrim(rtrim(lower(@Depu_Name)))))  
   BEGIN  
    -- TOLD NAME IS EXITS  
    SET @Output=-1   
    return @Output     
   END  
  ELSE  
     BEGIN  
    IF (@IsParent='1')  
      BEGIN  
     -- UPDATE THE TABLE  
     update DepuMaster set UnitName=@UnitName, IDT=@IDT,ICT=@ICT,AWS=@AWS, Depu_Name=@Depu_Name,Depu_Location=@Depu_Location,IsParent=@IsParent,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy     
   ,FormationId=@FormationId,Corp=@Corp,DepotNo=DepotNo  
     
     where  Depu_Id=@Depu_Id      
     SET @Output=@Depu_Id    
     return @Output     
      END  
      ELSE  
       BEGIN  
      SET @Output=-3  -- TOLD YOU HAVE TO SET THIS PARENT  
     return @Output     
       END  
    
     END  
 end  
 else  
 begin  
 -- is parent is zero  
  set @chkDepu_Name= (select Depu_Name From DepuMaster where ltrim(rtrim(lower((Depu_Name)))) = (ltrim(rtrim(lower(@Depu_Name)))) AND Depu_Id!=@Depu_Id)   
  if(ltrim(rtrim(lower((@chkDepu_Name)))) = (ltrim(rtrim(lower(@Depu_Name)))))  
   BEGIN  
    -- TOLD NAME IS EXITS  
     SET @Output = -1  
     return @Output     
   END  
  ELSE  
   BEGIN  
    IF (@IsParent='1')  
      BEGIN  
      if(@status='pending')  
      BEGIN  
        SET @Output = -2  -- YOU TOLD IT'S ALSO EXITS ARE YOU WANT TO MAKE THIS PARENT  
        return @Output  
      END   
     ELSE  
      BEGIN  
       -- HERE STATUS IS DONE SO YOU UPDATE HERE  
         set @uid=(select Depu_Id from DepuMaster where IsParent='1' and IsActive='1')    
                              update DepuMaster set IsParent='0' where Depu_Id=@uid    
                    
        update DepuMaster set UnitName=@UnitName, IDT=@IDT,ICT=@ICT,AWS=@AWS, Depu_Name=@Depu_Name,Depu_Location=@Depu_Location,IsParent=@IsParent,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy     
       ,FormationId=@FormationId,Corp=@Corp,DepotNo=DepotNo  
     
        where  Depu_Id=@Depu_Id      
        SET @Output=@Depu_Id    
        return @Output     
      END  
          
      END  
      ELSE  
       BEGIN   
      -- UPDATE THE TABLE  
     update DepuMaster set UnitName=@UnitName, IDT=@IDT,ICT=@ICT,AWS=@AWS, Depu_Name=@Depu_Name,Depu_Location=@Depu_Location,IsParent=@IsParent,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy     
    ,FormationId=@FormationId,Corp=@Corp,DepotNo=DepotNo  
     
     where  Depu_Id=@Depu_Id      
     SET @Output=@Depu_Id    
     return @Output     
       END  
   END  
 end  
    
 end          
 if(@Action='updateactive')          
   begin          
   update DepuMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  Depu_Id=@Depu_Id          
 end          
           
          
   if(@Action='removeParent')          
   begin          
   update depumaster set isparent=0        
 end          
END


GO
/****** Object:  StoredProcedure [dbo].[spESLIssue]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                  
-- Author:  <Author,,Ravi>                  
-- Create date: <Create 04-12-2014,,>                  
-- Description: <ESLInsertion,selection updation>                  
-- =============================================                  
                  
                  
                  
CREATE PROCEDURE [dbo].[spESLIssue]     
 -- Add the parameters for the stored procedure here                  
@EslID int=null,                  
@ProductID int=null,                  
@IssueTo varchar(50)=null,          
               
@Quantitytype varchar(50) = null,          
@Quantity varchar(50)=null,           
          
@StatusID int=null,              
@RemarksBynurGP varchar(50)=null,          
@RemarksByjcoiGP varchar(50)=null,          
@RemarksByjDSO varchar(50)=null,          
@OverallRemarks varchar(50)=null,          
 @AddedOn datetime=null,                  
 @AddedBy int=null,                  
 @ModifiedOn datetime=null,                  
 @ModifiedBy int=null,                 
 @Output int=nULL output,          
 @SentOn datetime=null,          
 @RecievedDate datetime=null,          
 @IsActive bit =null,          
 @PID int=null,              
 @SID int=null,           
 @Stockqty numeric(18,0)=null ,            
 @IsProductStatus varchar(50)=null,          
 @Action varchar(100)=null,           
  @fromdate datetime=null,          
 @todate datetime=Null,          
 @IsSentto  bit = null ,       
 @StartDate datetime=null,    
@EndDate datetime=null,    
@ApprovedId varchar(100)=null,       
 @Bid int=Null      
   AS            
                   
BEGIN                  
 -- SET NOCOUNT ON added to prevent extra result sets from                  
 -- interfering with SELECT statements.
              
-- Commentted by Rohit Pundeer           
-- if(@Action ='SelectStockQty')          
--begin          
      
           
-- --select sm.Quantity,BatchCode,       
-- --  (select qt.QuantityType from Quantitytype as qt  where qt.Id=sm.QuantityType) as QuantityTypename,      
-- --  sm.QuantityType,      
-- --  (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName        
-- --   From BatchMaster as bm        
-- -- inner join StockMaster as sm on sm.BID=bm.BID        
-- --  where bm.BID=@Bid and bm.IsActive=1 and bm.IsBatchStatus=1
 
-- ----- Changed by Rohit Pundeer
-- select sm.Quantity,bm.BatchCode,       
--   (select qt.QuantityType from Quantitytype as qt  where qt.Id=sm.QuantityType) as QuantityTypename,      
--   sm.QuantityType,      
--   (select Product_Name From ProductMaster as pm where pm.Product_ID= 
--   (select sm.ProductId where sm.SID = bm.StockId)) as ProductName        
--    From BatchMaster as bm        
--  inner join StockMaster as sm on sm.SID=bm.StockId        
--   where bm.BID=@Bid
        
       
--end

----- Added by Rohit Pundeer
if(@Action ='SelectProductAndStockDetails')          
begin    
 select bm.BatchNo as BatchNo,bm.MFGDate as MfgDate, bm.Esl as EslDate, bm.ModifiedOn as modiFyDate, bm.isBatchStatus as batchStatus,       
   (select sm.AddedOn from StockMaster as sm where sm.SID=bm.StockId) as ReceiptDate,
   (select sm.ATNo from StockMaster as sm where sm.SID=bm.StockId) as AtNo,
   (select sm.RecievedFrom from StockMaster as sm where sm.SID=bm.StockId) as SupplySource,
   (select sm.PackagingMaterialShape from StockMaster as sm where sm.SID=bm.StockId) as Shape,
   (select sm.PackagingMaterialSize from StockMaster as sm where sm.SID=bm.StockId) as Size,   
   (select pm.Product_Name From ProductMaster as pm where pm.Product_ID = 
   (select sm.ProductId From StockMaster as sm, BatchMaster as bm where sm.SID = bm.StockId and bm.BID = @Bid))  as ProductName       
    From BatchMaster as bm
	where bm.BID = @Bid   
end          
             
 if(@Action = 'Insert')                  
 begin                  
               
         
      insert into ESLIssue(BID,IssueTo,Quantitytype,Quantity,StatusID,RemarksBynurGP,RemarksByjcoiGP,RemarksByjDSO,OverallRemarks,SentOn,RecievedDate,IsActive,AddedOn,AddedBy,ModifiedBy,ModifiedOn)values                  
     (@Bid,@IssueTo,@Quantitytype,@Quantity,@StatusID,@RemarksBynurGP,@RemarksByjcoiGP, @RemarksByjDSO,@OverallRemarks,GETDATE(),@RecievedDate,@IsActive,GETDATE(),@AddedBy,@AddedBy,GETDATE());                  
     set @Output =SCOPE_IDENTITY();                  
           
  begin         
 update StockMaster set Quantity=Quantity-@Quantity , ModifiedBy=@AddedBy, ModifiedOn=GETDATE() where BID=@Bid        
 update BatchMaster set IsBatchStatus=4 , ModifiedBy=@AddedBy, ModifiedOn=GETDATE() where BID=@Bid        
         
 set @ProductID=(select PID From BatchMaster where BID=@Bid)        
 update ProductMaster set StockQty=StockQty-@Quantity , ModifiedBy=@AddedBy, ModifiedOn=GETDATE() where Product_ID=@ProductID        
  end          
   return @Output                
      end      
           
if(@Action = 'ESLIssueGridDisplay')        
begin       
   select esl.AddedOn as esldate,    
  (select qt.QuantityType From StockMaster as sm       
   inner join QuantityType as qt on qt.Id=sm.QuantityType      
   where sm.BID=bm.BID) as Quantitytype,      
   (select sm.Quantity From StockMaster as sm where sm.BID=bm.BID )as Quantity,      
   (select st.Status  from StatusMaster as st where st.Id= bm.IsBatchStatus) as Status  ,      
  (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName,      
  * from BatchMaster as bm       
  inner join ESLIssue as esl on esl.BID=bm.BID where esl.IsActive=1 and bm.IsBatchStatus=4    
      
      
  --select convert(date,addedon),* From ESLIssue    
    --update ESLIssue set AddedOn='2015-03-01 16:10:07.807' where EslID=58    
 --Select es.ProductID,  es.Quantitytype,es.Quantity,       
 --(select st.Status  from StatusMaster as st where st.Id= es.StatusID) as Status  ,       
 --(Select pm.Product_Name from ProductMaster as  pm where pm.Product_ID= es.ProductID ) as ProductName,      
 -- es.StatusID,      
 --es.RemarksBynurGP, es.RemarksByjcoiGP, es.RemarksByjDSO, es.OverallRemarks, es.IssueTo,es.RecievedDate from ESLIssue  as es where es.IsActive = 1        
 end       
     
     
       
if(@Action = 'FilterbyDate')      
begin      
 if((convert(date,@fromdate))=(CONVERT(Date,@todate)))    
 BEGIN    
     select esl.AddedOn as esldate,    
    (select qt.QuantityType From StockMaster as sm       
    inner join QuantityType as qt on qt.Id=sm.QuantityType      
    where sm.BID=bm.BID) as Quantitytype,      
    (select sm.Quantity From StockMaster as sm where sm.BID=bm.BID )as Quantity,      
    (select st.Status  from StatusMaster as st where st.Id= bm.IsBatchStatus) as Status  ,      
   (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName,      
   * from BatchMaster as bm       
   inner join ESLIssue as esl on esl.BID=bm.BID where esl.IsActive=1 and bm.IsBatchStatus=4    
   and CONVERT(date,esl.AddedOn) = convert(date,@fromdate)    
      
 END    
 ELSE    
  begin    
     select   esl.AddedOn as esldate,     
   (select qt.QuantityType From StockMaster as sm       
    inner join QuantityType as qt on qt.Id=sm.QuantityType      
    where sm.BID=bm.BID) as Quantitytype,      
    (select sm.Quantity From StockMaster as sm where sm.BID=bm.BID )as Quantity,      
    (select st.Status  from StatusMaster as st where st.Id= bm.IsBatchStatus) as Status  ,      
   (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName,      
   * from BatchMaster as bm       
   inner join ESLIssue as esl on esl.BID=bm.BID where esl.IsActive=1 and bm.IsBatchStatus=4    
   and CONVERT(date,esl.AddedOn)>= case when CONVERT(date,@fromdate) IS null then CONVERT(date,esl.AddedOn) else @fromdate end    
  and CONVERT(date,esl.AddedOn)<=case when convert(date,@todate) IS null then CONVERT(date,esl.AddedOn) else @todate end    
      
  end     
     
end     
  
  
if(@Action = 'SelectESLStatusbyID')    
begin    
        
      select sm.Quantity,BatchCode,esl.StatusID,esl.*,esl.Quantity AS eslquantity,  
      (select Status From StatusMaster where Id=bm.IsBatchStatus)as  Status ,      
   (select qt.QuantityType from Quantitytype as qt  where qt.Id=sm.QuantityType) as QuantityTypename,    
   sm.QuantityType,    
   (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName      
    From BatchMaster as bm      
   inner join StockMaster as sm on sm.BID=bm.BID   
   inner join ESLIssue as esl on esl.BID=bm.BID     
   where bm.BID=@Bid and bm.IsActive=1 and bm.IsBatchStatus=4    
   
 end    
    
  if(@Action = 'UpdateESLIssue')    
begin    
  if(@StatusID='2')  
   BEGIN  
   Update ESLIssue set StatusID = @StatusID ,RecievedDate = @RecievedDate,ModifiedBy=@ModifiedBy,ModifiedOn=@ModifiedOn  where BID = @Bid  
      
    update StockMaster set Quantity=Quantity+@Quantity , ModifiedBy=@ModifiedBy, ModifiedOn=GETDATE() where BID=@Bid      
   update BatchMaster set IsBatchStatus=@StatusID , ModifiedBy=@ModifiedBy, ModifiedOn=GETDATE() where BID=@Bid      
        
   set @ProductID=(select PID From BatchMaster where BID=@Bid)      
   update ProductMaster set StockQty=StockQty+@Quantity , ModifiedBy=@ModifiedBy, ModifiedOn=GETDATE() where Product_ID=@ProductID      
     
   END  
  ELSE  
   BEGIN  
   Update ESLIssue set StatusID = @StatusID ,RecievedDate = @RecievedDate,ModifiedBy=@ModifiedBy,ModifiedOn=@ModifiedOn  where BID = @Bid  
   
    update BatchMaster set IsBatchStatus=@StatusID , ModifiedBy=@ModifiedBy, ModifiedOn=GETDATE() where BID=@Bid      
   END  
 --Update ESLIssue set StatusID = @StatusID ,RecievedDate = @RecievedDate where ProductID = @ProductID      
end    
  
  
if(@Action='ESLIssueStatusGrid')      
begin    
      
select        
  (select qt.QuantityType From StockMaster as sm       
   inner join QuantityType as qt on qt.Id=sm.QuantityType      
   where sm.BID=bm.BID) as Quantitytype,      
   (select sm.Quantity From StockMaster as sm where sm.BID=bm.BID )as Quantity,     
   (select st.Status  from StatusMaster as st where st.Id= bm.IsBatchStatus) as Status  ,      
  (select Product_Name From ProductMaster as pm where pm.Product_ID=bm.PID) as ProductName,      
  * from BatchMaster as bm where bm.IsActive=1 --and bm.IsBatchStatus=@SID      
  --and convert(date,AddedOn)>=@AddedOn and convert(date,AddedOn)>=@ModifiedOn      
end      
 
---- Modified by Rohit Pundeer     
--if(@Action='StatusOfESLIssueGrid')      
--begin      
--SELECT dbo.ESLIssue.IssueTo, (Select QuantityType from QuantityType where Id=dbo.ESLIssue.Quantitytype)as Quantitytype, dbo.ESLIssue.Quantity, dbo.ESLIssue.Quantity,    
--(select Product_Name from ProductMaster  where Product_ID=(select PID from BatchMaster    
-- where BID=dbo.ESLIssue.BID)) as ProductName,    
-- dbo.BatchMaster.BatchName,  dbo.BatchMaster.IsSentto, dbo.BatchMaster.BID, dbo.BatchMaster.Esl,    
-- dbo.ESLIssue.SentOn, dbo.ESLIssue.RecievedDate    
-- ,(Select Status From StatusMaster where  dbo.StatusMaster.Id =dbo.ESLIssue.StatusID ) as Status    
--FROM       dbo.ESLIssue left  JOIN    
--          dbo.BatchMaster ON dbo.ESLIssue.BID = dbo.BatchMaster.BID     
--end      
   ---- Added by Rohit Pundeer    
    if(@Action='EslViewDetailsGrid')      
    begin
	Select f.Id as FnId, f.batchId as batchId, b.Esl as CurEsl, b.BatchNo as BatchNumber, p.Product_Name as ProductName, c.Type as Category,
	b.IsBatchStatus as batchStatus, f.OldEslDate as PreEsl, f.EslModifyDate as ModDate, f.forwardingNoteNumber as FnNumber
    From BatchMaster as b, StockMaster as s, ProductMaster as p, ForwardNoteMaster as f, CategoryType as c
    where b.StockId = s.SID AND s.ProductId = p.Product_ID And c.ID = p.Category_Id And b.BID = f.batchId And f.isForwardingNoteActive=0 
	end	
	
	  
if(@Action='ChangeGridStatus')      
begin      
  SELECT     dbo.ESLIssue.IssueTo, (Select QuantityType from QuantityType where Id=dbo.ESLIssue.Quantitytype)as Quantitytype, dbo.ESLIssue.Quantity, dbo.ESLIssue.Quantity,    
(select Product_Name from   ProductMaster  where Product_ID=(select PID from BatchMaster    
 where BID=dbo.ESLIssue.BID)) as ProductName,    
 dbo.BatchMaster.BatchName,  dbo.BatchMaster.IsSentto, dbo.BatchMaster.BID, dbo.BatchMaster.Esl,    
 dbo.ESLIssue.SentOn, dbo.ESLIssue.RecievedDate    
 ,(Select Status From StatusMaster where  dbo.StatusMaster.Id =dbo.ESLIssue.StatusID ) as Status    
FROM       dbo.ESLIssue left  JOIN    
          dbo.BatchMaster ON dbo.ESLIssue.BID = dbo.BatchMaster.BID    
           where     
  -- CONVERT(date,dbo.ESLIssue.SentOn)> =CONVERT(date,@StartDate) and     
  -- CONVERT(date,dbo.ESLIssue.SentOn)<= CONVERT(date,@EndDate)      
   BatchMaster.IsBatchStatus=@StatusID    
end      
      
      
  if(@Action='FilterbyDateAndId')    
  begin    
  SELECT     dbo.ESLIssue.IssueTo, (Select QuantityType from QuantityType where Id=dbo.ESLIssue.Quantitytype)as Quantitytype, dbo.ESLIssue.Quantity,    
(select Product_Name from ProductMaster  where Product_ID=(select PID from BatchMaster    
 where BID=dbo.ESLIssue.BID)) as ProductName,    
 dbo.BatchMaster.BatchName,  dbo.BatchMaster.IsSentto, dbo.BatchMaster.BID, dbo.BatchMaster.Esl,    
 dbo.ESLIssue.SentOn, dbo.ESLIssue.RecievedDate    
 ,(Select Status From StatusMaster where  dbo.StatusMaster.Id =dbo.ESLIssue.StatusID ) as Status    
FROM       dbo.ESLIssue left  JOIN    
          dbo.BatchMaster ON dbo.ESLIssue.BID = dbo.BatchMaster.BID    
           where     
   CONVERT(date,dbo.ESLIssue.SentOn)> =CONVERT(date,@StartDate) and     
   CONVERT(date,dbo.ESLIssue.SentOn)<= CONVERT(date,@EndDate)      
   and BatchMaster.IsBatchStatus=@ApprovedId    
  end    
      
END


GO
/****** Object:  StoredProcedure [dbo].[speslstatus]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[speslstatus]    
(  
 @Action varchar(50)=Null,  
 @ID INT=nULL  
)  
as  
   
    
   
  BEGIN  

   
   
    if(@Action='Select')  
   BEGIN  
   
   
    select BID, AddedOn as dateofreceipt,BatchCode as crvno      
 ,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate      
 ,Esl AS ESLDATE  ,EXPDate     
  ,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRED' ELSE       
 case WHEN Esl<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'  ,    
 PID as ProductID, (select PM.Product_Name    
  from ProductMaster as PM where PM.Product_ID = PID) as ProductName,    
  (select PM.IsProductStatus    
  from ProductMaster as PM where PM.Product_ID = PID) as IsProductStatus    
 from BatchMaster  where IsSentto ='false'  ORDER BY AddedOn DESC   
 --  select BID, AddedOn as dateofreceipt,BatchCode as crvno    
 --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
 --,Esl AS ESLDATE  ,EXPDate   
 -- ,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRED' ELSE     
 --case WHEN Esl<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'  ,  
 --PID as ProductID, (select PM.Product_Name  
 -- from ProductMaster as PM where PM.Product_ID = PID) as ProductName,  
 -- (select PM.IsProductStatus  
 -- from ProductMaster as PM where PM.Product_ID = PID) as IsProductStatus  
 --from BatchMaster  where IsSentto ='false'  ORDER BY AddedOn DESC  
 
 
 
 --UPDATE BatchMaster SET EXPDate='2015-08-04 00:00:00.000' WHERE BID=10  
 --select * from BatchMaster  
    
 --   select BID,AddedOn as dateofreceipt,BatchCode as crvno    
 --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
 --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
 --,case when EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE() then 'ESL' ELSE 'not' end as 'ProductStatus'    
 --from BatchMaster where EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE()    
     
       
 --  select BID,AddedOn as dateofreceipt,BatchCode as crvno    
 --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
 --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
 --,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
 --case WHEN DATEADD(month,-6, EXPDate)<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'    
 --from BatchMaster    
     
 --   select BID,AddedOn as dateofreceipt,BatchCode as crvno    
 --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo    
 --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
 --, CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
 -- case WHEN DATEADD(month,-6, EXPDate)<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as ProductStatus    
 --,case when EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE() then 'ESL' ELSE 'not' end as 'expdetail'    
 --from BatchMaster where EXPDate>=GETDATE()    
     
 --   select BID,AddedOn as dateofreceipt,BatchCode as crvno    
 --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo    
 --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
 --,case when EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE() then 'ESL' ELSE 'not' end as 'ProductStatus'    
 --from BatchMaster where EXPDate>=GETDATE()    
     
   END   
     if(@Action='bindgrid')
     begin
      select BID, AddedOn as dateofreceipt,BatchCode as crvno    
 ,RecievedFrom as fromwhomreceived,(select RecievedFrom from RecievedFrom where Id=BatchMaster.RecievedFrom) As RecievedFroms, ATNo as atnodate ,BatchNo,MFGDate    
 ,Esl AS ESLDATE  ,EXPDate   
  ,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRED' ELSE     
 case WHEN Esl<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'  ,  
 PID as ProductID, (select PM.Product_Name  
  from ProductMaster as PM where PM.Product_ID = PID) as ProductName,  
  (select PM.IsProductStatus  
  from ProductMaster as PM where PM.Product_ID = PID) as IsProductStatus  
 from BatchMaster 
 
   where IsSentto ='false'  ORDER BY AddedOn DESC  
     end
   IF(@Action='SIXMONTH')  
   BEGIN  
     select BID,AddedOn as dateofreceipt,BatchCode as crvno    
     ,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
     ,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
     ,case when EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE() then 'ESL' ELSE 'not' end as 'ProductStatus',  
      PID as ProductID, (select PM.Product_Name  
  from ProductMaster as PM where PM.Product_ID = PID) as ProductName,  
  (select PM.IsProductStatus  
  from ProductMaster as PM where PM.Product_ID = PID) as IsProductStatus  
    
    
     from BatchMaster    where EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE()    
       
  --SELECT BID,AddedOn as dateofreceipt,BatchCode as crvno    
  --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
  --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
  --,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
  --case WHEN DATEADD(month,-6, EXPDate)<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'    
  --from BatchMaster    
     
   END   
     
    IF(@Action='SELECTWITHID')  
   BEGIN  
     select BID,AddedOn as dateofreceipt,BatchCode as crvno    
     ,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
     ,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
     ,case when EXPDate>=GETDATE() AND DATEADD(MONTH,-6,EXPDate)< GETDATE() then 'ESL' ELSE 'not' end as 'ProductStatus' ,  
        PID as ProductID, (select PM.Product_Name  
  from ProductMaster as PM where PM.Product_ID = PID) as ProductName,  
  (select PM.IsProductStatus  
  from ProductMaster as PM where PM.Product_ID = PID) as IsProductStatus  
    
     from BatchMaster where BID=@ID  
         
       
  --SELECT BID,AddedOn as dateofreceipt,BatchCode as crvno    
  --,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
  --,DATEADD(month,-6, EXPDate) as ESLDATE,EXPDate    
  --,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
  --case WHEN DATEADD(month,-6, EXPDate)<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'    
  --from BatchMaster    
     
   END   
   
   if(@Action='selectpendingbatch')
	begin
		--select BM.* From BatchMaster BM
	
		-- where BM.IsActive=1 and BM.IsBatchStatus='1'
--	select BID, AddedOn as dateofreceipt,BatchCode as crvno , ATNo as atnodate ,BatchNo,MFGDate      
-- ,Esl AS ESLDATE  ,EXPDate ,sta.Status,    
--(select pm.Product_Name From ProductMaster as pm where pm.Product_ID=BatchMaster.PID) as ProductName, 
--(select rf.RecievedFrom from RecievedFrom as rf where rf.Id=BatchMaster.RecievedFrom) as RecievedFroms,
--* From BatchMaster 
--INNER JOIN StatusMaster AS sta on sta.Id=BatchMaster.IsBatchStatus
--where BatchMaster.IsActive=1 and IsBatchStatus='1' and sta.Id=1  

--select BID, AddedOn as dateofreceipt, BatchCode as crvno , ATNo as atnodate ,BatchNo,MFGDate      
-- ,Esl AS ESLDATE  ,EXPDate ,sta.Status,    
--(select pm.Product_Name From ProductMaster as pm where pm.Product_ID=BatchMaster.PID) as ProductName, 
--(select rf.RecievedFrom from RecievedFrom as rf where rf.Id=BatchMaster.RecievedFrom) as RecievedFroms,
--* From BatchMaster 
--INNER JOIN StatusMaster AS sta on sta.Id=BatchMaster.IsBatchStatus
--where BatchMaster.IsActive=1 and IsBatchStatus='1' and sta.Id=1

------ Changed by Rohit Pundeer
Select b.BID as BID, s.AddedOn as ReceivedDate, b.MFGDate as MfgDate, b.BatchNo as BatchNo,
 b.Esl as EslDate, b.EXPDate as ExpDate, p.Product_Name as ProductName, s.CRVNo as CrvNo, 
 s.RecievedFrom as ReceivedFrom, s.OtherSupplier as Supplier, s.ATNo as AtNo, p.IsProductStatus as Status
From BatchMaster as b, StockMaster as s, ProductMaster as p
where b.StockId = s.SID AND s.ProductId = p.Product_ID AND (b.IsBatchStatus='Fit'or b.IsBatchStatus is null)
order by b.Esl

	end
END


GO
/****** Object:  StoredProcedure [dbo].[spExpenseVoucherList]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  <Author,,Name>            
-- Create date: <Create Date,,>            
-- Description: <Description,,>            
-- =============================================            
CREATE PROCEDURE [dbo].[spExpenseVoucherList]            
 @Action varchar(500)=''   ,
 @BID int=0 ,
 @IDs varchar(max)=null        
AS            
BEGIN            
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
 SET NOCOUNT ON;
 if(@Action='PendingByIDs') 
 begin
 select * from tblExpensePMContainer t
 inner join AddPMContainer a on a.ID=t.PMContainerId
 inner join PMandContainerMaster p on p.Id=a.PMID
 inner join CategoryMaster c on a.CategoryID=c.ID
 
  where t.Id in(select * from Split(@IDs,',')) 
 end    
 if(@Action='PendingByBID')            
begin            
select cm.Category_Name,pm.Product_Name,pm.productUnit,bm.BatchNo,bm.SampleSentQty,bm.BID, pm.Product_ID,cm.ID as CID        
,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full') as FormatFull,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose') as FormatLoose,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW') as FormatDW,        
          
(select sum(sp.RemainingQty) from StockPakaging sp where sp.StockBatchId=bm.BID ) as RemainingQty,            
(select sp.SampleAffected from StockSpillage sp where sp.StockBatchId=bm.BID ) as DamagedBox         
,sm.AddedOn        
   
from  BatchMaster bm             
inner join StockMaster sm on bm.StockId =sm.SID            
inner join ProductMaster pm on pm.Product_ID=sm.ProductId            
inner join CategoryMaster cm on cm.ID =pm.Category_Id            
 where   
 bm.BID=@BID and          
 bm.BID not in(select Batchid from  ExpenseVoucherMaster) and            
  CONVERT(varchar(max), bm.SampleSentQty)<>''  and bm.BID in (select p.StockBatchId from StockPakaging p)  and bm.StockId in (select sm.SID from StockMaster sm where sm.CRVNo<>'')           

        
end              
if(@Action='Pending')            
begin            
select cm.Category_Name,pm.Product_Name,pm.productUnit,bm.BatchNo,bm.SampleSentQty,bm.BID, pm.Product_ID,cm.ID as CID        
,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full') as FormatFull,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose') as FormatLoose,            
(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW') as FormatDW,        
          
(select sum(sp.RemainingQty) from StockPakaging sp where sp.StockBatchId=bm.BID ) as RemainingQty,            
(select sp.SampleAffected from StockSpillage sp where sp.StockBatchId=bm.BID ) as DamagedBox         
,sm.AddedOn        
   
from  BatchMaster bm             
inner join StockMaster sm on bm.StockId =sm.SID            
inner join ProductMaster pm on pm.Product_ID=sm.ProductId            
inner join CategoryMaster cm on cm.ID =pm.Category_Id            
 where             
 bm.BID not in(select Batchid from  ExpenseVoucherMaster) and            
  CONVERT(varchar(max), bm.SampleSentQty)<>''  and bm.BID in (select p.StockBatchId from StockPakaging p)  and bm.StockId in (select sm.SID from StockMaster sm where sm.CRVNo<>'')           
order by  bm.BID desc        
        
end            
if(@Action='Generated')            
begin            
 select cm.Category_Name,pm.Product_Name,pm.productUnit,bm.BatchNo,ex.* from  ExpenseVoucherMaster ex            
 inner join BatchMaster bm on bm.BID =ex.BatchID            
inner join ProductMaster pm on pm.Product_ID=ex.ProductID            
inner join CategoryMaster cm on cm.ID =ex.CategoryID            
end            
END


GO
/****** Object:  StoredProcedure [dbo].[spExpenseVoucherSummary]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================              
-- Author:  <Author,,Name>              
-- Create date: <Create Date,,>              
-- Description: <Description,,>              
-- =============================================              
CREATE PROCEDURE [dbo].[spExpenseVoucherSummary]              
 @Action varchar(500)=''  ,      
 @Id int=0            
AS              
BEGIN              
 -- SET NOCOUNT ON added to prevent extra result sets from              
 -- interfering with SELECT statements.              
 SET NOCOUNT ON;             
 if(@Action='GetPMContiner')              
begin              
 select ep.*, ap.* ,      
cm.Category_Name,bm.BatchNo,pm.Product_Name,pm.productUnit,      
pmc.*         
 from tblExpensePMContainer ep     
 inner join AddPMContainer ap on ep.PMContainerId=ap.ID       
inner join PMandContainerMaster pmc on pmc.Id=ap.PMID      
inner join BatchMaster bm on bm.BID=(select BatchID from ExpenseVoucherMaster where ID=@Id)    
inner join ProductMaster pm on pm.Product_ID=(select ProductID from ExpenseVoucherMaster where ID=@Id)    
inner join CategoryMaster cm on cm.ID=ap.CategoryID     
where  ap.CategoryID=(select CategoryID from ExpenseVoucherMaster where ID=@Id)    
      
      
end               
      
if(@Action='Summary')              
begin              
 select       
 sm.SID,      
 bm.BID,ex.ID,pm.Product_ID,pm.Product_Name,pm.productUnit,      
 isnull('AT No: '+sm.ATNo,'SO No: '+sm.SupplierNo)  as ATSONo ,      
 (bm.WeightofParticular*ex.RemainingQty) as vWeight,      
 (bm.CostOfParticular) as vCost,      
   ex.UsedFromFullPackets,ex.UsedQty,ex.FormatFull,ex.FormatLoose,ex.Remarks,ex.RemainingQty,ex.AddedOn as ExAddedOn,      
   bm.BatchNo,cm.Category_Name,    
   (select COUNT(*) from tblExpensePMContainer ap where ap.ExpenseVoucherNo=ex.ExpenseVoucherNo) as PMCount       
      ,bm.MFGDate    ,bm.EXPDate,bm.Esl    
 from  ExpenseVoucherMaster ex              
 inner join BatchMaster bm on bm.BID =ex.BatchID              
inner join ProductMaster pm on pm.Product_ID=ex.ProductID              
inner join CategoryMaster cm on cm.ID =ex.CategoryID       
inner join StockMaster sm on sm.SID=bm.StockId        
      
where ex.ID=@Id           
end              
END


GO
/****** Object:  StoredProcedure [dbo].[spGetBatchByProduct]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetBatchByProduct]  
 @PID int=null  
AS  
BEGIN  
 select Upper(BatchCode+' '+ BatchName) as Batch ,SM.Quantity,* from BatchMaster BM  
 inner join StockMaster SM on SM.BID=BM.BID   
   
   
  where  SM.Quantity>0  
   and  BM.PID=@PID  
END


GO
/****** Object:  StoredProcedure [dbo].[SpGetIDTRecord]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[SpGetIDTRecord] 
	@Action varchar(100)=null,
	@IDT int=null
AS
BEGIN
if (@Action='GetIDTRecord')
	Begin
			SELECT     TOP (1) dbo.IDT.Id, StockTransfer.ID, StockTransfer.DepuMasterId, StockTransfer.IsUnit,
		 dbo.StockTransfer.UnitMasterId, dbo.StockTransfer.IndentId, 
		 dbo.StockTransfer.IsActive, dbo.IDT.IndentName
		FROM         dbo.IDT INNER JOIN
							  dbo.StockTransfer ON dbo.IDT.Id = dbo.StockTransfer.IndentId
		WHERE     (dbo.IDT.Id = @IDT)
	End
	
END


GO
/****** Object:  StoredProcedure [dbo].[spGetIssuedIDT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[spGetIssuedIDT]
	@pID int=0,
	@dID int =0,
            @qID int =0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select 
(select Product_Name from ProductMaster where Product_ID=idt.ProductID) as ProductName,
(select productUnit from ProductMaster where Product_ID=idt.ProductID) as AU,
(select d.Depu_Name from DepuMaster d where d.Depu_Id=idt.DepuID) as Depot,
(select QuarterRange from tbl_idtQty_Quarter where id=idt.Qid) as Quarter,
* from tbl_batchIdt idt
inner join BatchMaster bm on bm.BID=idt.BID
where idt.ProductID=@pID and idt.DepuID=@dID and idt.Qid=@qID
--where idt.issueorder_Status=0 and idt.IssueOrderId=0 and idt.ProductID=@pID and idt.DepuID=@dID and idt.Qid=@qID


END


GO
/****** Object:  StoredProcedure [dbo].[spGetWareHouseSections]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[spGetWareHouseSections]    
 @Action varchar(50)=''    
AS    
BEGIN    
     
 if(@Action='Sections')    
 begin    
 select w.WareHouseNo,s.* from tblSection s    
 inner join tblWarehouse w on w.ID=s.WarehouseID    
 end    
 if(@Action='WarehouseNo')    
 begin    
     
 select wt.WareHouseNo as Name from tblWarehouse wt     
 union select    
  CAST(CASE when SubSection='' then w.WareHouseNo+'/'+s.Section     
  else w.WareHouseNo+'/'+s.Section +'/'+s.SubSection end as varchar(500) ) as Name from tblWarehouse w right join tblSection s on s.WarehouseID=w.ID    
 
 
 
 end    
    
    
     
        
END


GO
/****** Object:  StoredProcedure [dbo].[spIDTStockTranfer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[spIDTStockTranfer]    
@SID int=null,    
@BatchId int=null,    
@IDTId int =null,    
@PackingType varchar(10)='',    
@Quantity decimal(18,3)=null,    
@Format varchar(100)=null,    
@ToLooseCount int=0 
--@Output int=0 output    
 AS    
BEGIN  

DECLARE 
@Output int=0,
@Qty decimal (18,3)=0
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 --(select Id from IDTStockTransfer where BatchId=7 and IDTId=8  and PackingType='Full' )    
set @Output=(select Id from IDTStockTransfer where BatchId=@BatchId and IDTId=@IDTId  and PackingType=@PackingType )    
if(@Output>0)    
begin   

    select @Qty=Quantity from IDTStockTransfer where Id=@Output
update IDTStockTransfer set ToLooseCount=@ToLooseCount, BatchId=@BatchId , IDTId=@IDTId  , PackingType=@PackingType , Quantity=@Quantity , Format=@Format,Dated=GETDATE() where Id=@Output    
 update StockMaster set IssueQty=IssueQty+@Quantity-@Qty where SID=@SID    
end    
else    
begin    
INSERT INTO IDTStockTransfer VALUES (@BatchId, @IDTId,@PackingType,@Quantity,@Format,GETDATE(),@ToLooseCount, @Quantity, @Format)    
     
   update StockMaster set IssueQty=IssueQty+@Quantity where SID=@SID    
       
     
end    
    
END



GO
/****** Object:  StoredProcedure [dbo].[SPINDENT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SPINDENT]          
(          
 @Id int  =null         
,@IndentName varchar(100) =null           
,@IsApproved bit   =null         
,@IsIssueVoucherId bit  =null          
,@AddedBy int   =null         
,@AddedOn datetime   =null         
,@ModifiedBy int   =null         
,@ModifiedOn int   =null         
,@IsActive bit   =null         
,@Action varchar(100)=null         
,@Output int=null out         
,@indentid int =null         
,@idt int =null        
)          
AS          
          
BEGIN          
 IF(@Action='insert')          
  begin          
          
   INSERT INTO IDT          
           ([IndentName]          
           ,[AddedBy]          
           ,[AddedOn]          
           ,[IsActive])          
     VALUES          
       (@IndentName          
       ,@AddedBy          
       ,GETDATE()          
       ,1        
       )          
       set @idt=(select @@IDENTITY)       
       update IDT set IndentName=convert(varchar(100),'IDT/'+CONVERT(VARCHAR(12),GETDATE(),105)+'/'+convert(varchar(8),@idt))      
          WHERE Id=@idt      
              
      select @@IDENTITY      
  end          
 IF(@Action='selectid')          
  begin          
     select * from IDT where id=@Id          
  end          
          
  if(@Action='IndentUpdate')        
  begin        
  update IDT set IndentName=@IndentName,ModifiedBy=@ModifiedBy,ModifiedOn=@ModifiedOn,IsActive=@IsActive where  Id=@Id        
  end        
          
  if(@Action='InActive')        
  begin        
   Update IDT set IsActive =0 where Id=@Id        
  end        
        
  if(@Action='Select')        
  begin        
     select sm.*,dt.*,        
   (select Product_Name  from ProductMaster where Product_ID=sm.ProductMasterId) as ProductName,        
   (select Type from CategoryType where Id=sm.CategoryTypeID) as CategoryType ,        
   (Select Unit_Name from UnitMaster where Unit_Id=sm.UnitMasterId)as UnitType,        
   (select Depu_Name from DepuMaster where Depu_Id=sm.DepuMasterId)as DepotName         
    from StockTransfer sm   inner join IDT dt on dt.Id=sm. IndentId  ORDER BY  sm.AddedOn DESC        
  end        
   if (@Action='SelectAll')      
 BEGIN      
    select * from IDT WHERE IsActive=1       
         
 END      
       
 if (@Action='SelectIssueVoucherId')      
 BEGIN      
    select * from IDT WHERE IsActive=1 and IsApproved=1 and IsIssueVoucherId is null      
 END      
          
  if(@Action='Viewdetails')        
  begin        
     select sm.*,dt.*,        
   (select Product_Name  from ProductMaster where Product_ID=sm.ProductMasterId) as ProductName,        
   (select Type from CategoryType where Id=sm.CategoryTypeID) as CategoryType ,        
   (Select Unit_Name from UnitMaster where Unit_Id=sm.UnitMasterId)as UnitType,        
   (select Depu_Name from DepuMaster where Depu_Id=sm.DepuMasterId)as DepotName         
    from StockTransfer sm   inner join IDT dt on dt.Id=sm. IndentId  where sm.IndentId=@indentid         
    ORDER BY  sm.AddedOn DESC        
  end        
          
  if(@Action='UpdateindentApprove')        
  begin        
          
  update IDT set IsApproved=@IsApproved where Id=@Id          
  end        
          
          
   if(@Action='UpdateindentReject')        
  begin         
  update IDT set IsApproved=@IsApproved where Id=@Id          
  end        
          
          
 if(@Action='GridDisplay')       
    begin      
    select * from IDT       
    end      
          
   if(@Action='GetDetail')      
   begin      
   select * from IDT where IsApproved=1 and IsTallySheetId is null order by AddedOn      
   end      
         
   if(@Action='GridDisplayfortally')      
   begin      
   select * from IDT where IsApproved=1 and IsActive=1 and IsTallySheetId is null order by AddedOn      
   end      
         
   if(@Action='Getlist')      
   begin      
    select idt.Id as indentid,      
  ( select Product_Name from ProductMaster as pm where pm.Product_ID=st.ProductMasterId) as productname      
  ,st.ProductMasterId,      
   (select qt.QuantityType from StockMaster as sm       
    inner join QuantityType as qt on qt.Id=convert(varchar,sm.QuantityType)     --convert(int,sm.QuantityType)  
    where sm.BID=bm.BID) as AuUnitName ,      
    st.QtyIssued as qty, bm.MFGDate as'domdate',bm.EXPDate 'esldate',* From IDT as idt         
   inner join StockTransfer as st on st.IndentId=idt.Id        
   --inner join ProductMaster as pm on st.ProductMasterId=pm.Product_ID        
   inner join BatchMaster as bm on bm.BID=st.BatchMasterId      
   where idt.Id=@idt and idt.IsActive=1 and idt.IsApproved=1        
    and idt.IsTallySheetId is null      
   end      
        
        
     if(@Action='GridDisplayfortally')      
   begin      
     select * from IDT where IsActive=1 and IsApproved=1 and IsIssueVoucherId=1 and    
      IsGateOut is NULL order by AddedOn  desc    
   end    
    
       if(@Action='SelectGateInoutList')      
   begin      
     select * from IDT where IsActive=1 and IsApproved=1 and IsIssueVoucherId=1 and    
      IsGateOut is NULL order by AddedOn  desc    
   end    
  END


GO
/****** Object:  StoredProcedure [dbo].[spIssueVoucherVehicleUpdate]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spIssueVoucherVehicleUpdate]
	-- Add the parameters for the stored procedure here
	 @IssueVoucherId varchar(500)         
 ,@ProductId int         
 ,@VehicleNo varchar(50)          
      
 ,@StockQuantity decimal(9, 2)   ,       
  @FormatFull varchar(MAX),  
    @FormatLoose varchar(MAX) ,     
 
    @BatchNo   varchar(50)    ,
  @issueorderid int, 
  
  @Id int=null,  
  @intResult int output             
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 declare @IssueorderNo nvarchar(max)   
  select @IssueorderNo=IssueOrderNo from tbl_IssueOrder where issueorderid=@issueorderid            
update tblIssueVoucherVehicleDetail set  
IssueVoucherId=@IssueVoucherId,
ProductId=@ProductId,VehicleNo=@VehicleNo,StockQuantity=@StockQuantity ,FormatFull =@FormatFull,  
 FormatLoose  = @FormatLoose  ,BatchNo = @BatchNo           
 where Id=@Id       
        
  update tbl_IssueOrder set orderstatusid=1 where  productid=@ProductId and IssueOrderNo=@IssueorderNo      
        
  Set @intResult = 1                    
                    
             
 Select @intResult   
END


GO
/****** Object:  StoredProcedure [dbo].[spLPCPList]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  <Author,,Name>            
-- Create date: <Create Date,,>            
-- Description: <Description,,>            
-- =============================================            
CREATE PROCEDURE [dbo].[spLPCPList]          
 @Action varchar(500)=''  ,  
 @IsATNo int=0,  
 @ID int=0 ,  
  @Status int= 0,  
  @Tender int= 0,  
   @FromDate datetime=null,
     @ToDate datetime=null,
  @Late int=0,  
  @Dispute int=0 ,
  @ATNO varchar(500)='', 
   @SONO varchar(500)='',
    @ProductID int=0  
AS            
BEGIN            
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
 SET NOCOUNT ON;   
 if(@Action='GetProductDetail')            
begin 
           
   select       
 (select ct.ID from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as CatID,      
 sm.SupplierId,      
 sm.SubPMShape,sm.SubPMSize,sm.SubShapeUnit,sm.SubWeight,sm.SubWeightUnit,      
 sm.PackingMaterial as PMName,      
 sm.IsEmptyPM,sm.IsWithoutPacking,      
 sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
   as SubPackingMaterial,      
sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
   as PackingMaterial,      
 sm.SupplierNo,      
   sm.ATNO,      
 ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo)  as ATSONo,      
 (sm.CostOfParticular*sm.Quantity) as Amount,      
  (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
 (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
 (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
 (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
 sm.Quantity, sm.BID,sm.OriginalManf,sm.OtherSupplier,sm.PackagingMaterialFormatLevel,sm.PackagingMaterialShape,sm.PackagingMaterialSize,      
 sm.PackingMaterial,sm.PackingMaterialFormat,sm.RecievedFrom,      
 ISNULL('['+ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO +'] ' +sm.Remarks ,'['+ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo+'] ' +sm.Remarks) as Remarks,      
  sm.ShapeUnit,sm.TransferedBy,sm.Weight,sm.WeigthUnit      
  ,sm.SID,sm.CostOfParticular,sm.CRVNo,sm.AddedOn ,sm.RecievedOn,sm.IsSubPacking,sm.IsDW ,sm.Remarks as Remarks1,sm.SubPMName as SUBPMName from StockMaster sm 
  where sm.ProductId =@ProductID and sm.ATNo=@ATNO and sm.SupplierNo=@SONO 
      
end 
if(@Action='LPCPByID')            
begin            
    select  
    (select count(*) from tblLPCP c where c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)   ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) ) as Dispute,
   
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where m.ID=@ID  
      
end      
 if(@Action='LPCPListByID')            
begin            
    select  
    (select count(*) from tblLPCP c where c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)   ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) ) as Dispute,
   
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where m.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and m.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and m.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and m.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and m.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  
      
end               
if(@Action='LPCPList')            
begin            
    select 
      (select count(*) from tblLPCP c  ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0  ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0  ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1  ) as Dispute,

       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
      
      
end        
if(@Action='GetByATSO')            
begin            
    select  
    (select count(*) from tblLPCP c where c.IsATNo=@IsATNo   ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and c.IsATNo=@IsATNo  ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and c.IsATNo=@IsATNo ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and c.IsATNo=@IsATNo) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1  and c.IsATNo=@IsATNo) as Dispute,
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
      
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where  m.IsATNo=@IsATNo  
end         
if(@Action='GetByATSOByID')            
begin            
    select  
(select count(*) from tblLPCP c where c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and c.IsATNo=@IsATNo    ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)and c.IsATNo=@IsATNo    ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and c.IsATNo=@IsATNo  ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and c.IsATNo=@IsATNo  ) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and c.IsATNo=@IsATNo   ) as Dispute,
   
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
      
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where m.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and m.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and m.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and m.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and m.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  
    and m.IsATNo=@IsATNo  
end     
if(@Action='GetByStatusByID')            
begin     
  
select  
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
      
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where m.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and m.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and m.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and m.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and m.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  
    and m.Status=@Status and m.Late=@Late and m.Dispute=@Dispute  
       
      
end                
   if(@Action='GetByStatus')            
begin     
  
select  


       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
      
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where  m.Status=@Status and m.Late=@Late and m.Dispute=@Dispute  
        
      
end              


if(@Action='LPCPByDateByID')            
begin            
   
        
        if(@Tender=1)            
begin         
    select  
    (select count(*) from tblLPCP c where c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  and  c.TenderDate between @FromDate and  @ToDate  ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)   and  c.TenderDate between @FromDate and  @ToDate) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  and  c.TenderDate between @FromDate and  @ToDate) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and  c.TenderDate between @FromDate and  @ToDate) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and  c.TenderDate between @FromDate and  @ToDate ) as Dispute,
 
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where m.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and m.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and m.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and m.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and m.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  and 
      --  m.TenderDate>@FromDate and m.TenderDate< @ToDate
              m.TenderDate between @FromDate and  @ToDate
    end
    else
    begin
      select  
       (select count(*) from tblLPCP c where c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  and  c.DeliveryDate between @FromDate and  @ToDate  ) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)   and  c.DeliveryDate between @FromDate and  @ToDate) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)  and  c.DeliveryDate between @FromDate and  @ToDate) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and  c.DeliveryDate between @FromDate and  @ToDate) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1 and  c.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and c.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and c.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and c.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and c.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID) and  c.DeliveryDate between @FromDate and  @ToDate ) as Dispute,
 
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where  m.SupplierID=(select SupplierID from tblLPCP where ID=@ID)  
    and m.ATSONo=(select ATSONo from tblLPCP where ID=@ID)  
      and m.TenderDate=(select TenderDate from tblLPCP where ID=@ID)  
       and m.LDPer=(select LDPer from tblLPCP where ID=@ID)  
        and m.SupplierContactNo=(select SupplierContactNo from tblLPCP where ID=@ID)   and 
        m.DeliveryDate between @FromDate and  @ToDate
       -- m.DeliveryDate>@FromDate and m.DeliveryDate< @ToDate
    end
    
      
end               
if(@Action='LPCPByDate')            
begin     
if(@Tender=1)            
begin         
    select  
    (select count(*) from tblLPCP c  where c.TenderDate between @FromDate and  @ToDate) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.TenderDate between @FromDate and  @ToDate ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.TenderDate between @FromDate and  @ToDate ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.TenderDate between @FromDate and  @ToDate) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1  and  c.TenderDate between @FromDate and  @ToDate) as Dispute,
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where
 m.TenderDate between @FromDate and  @ToDate
     --m.TenderDate between '2016-4-14' and  '2016-4-30' 
     --select GETDATE()
    --  m.TenderDate>@FromDate and m.TenderDate< @ToDate
    end
    else
    begin
      select 
       (select count(*) from tblLPCP c  where c.DeliveryDate between @FromDate and  @ToDate) as All1,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=0 and  c.DeliveryDate between @FromDate and  @ToDate ) as Processing,
(select count(*) from tblLPCP c where c.Status=0 and c.Late=1 and c.Dispute=0 and  c.DeliveryDate between @FromDate and  @ToDate ) as Late,
(select count(*) from tblLPCP c where c.Status=1 and  c.Dispute=0 and  c.DeliveryDate between @FromDate and  @ToDate) as Completed,
(select count(*) from tblLPCP c where c.Status=1 and c.Late=0 and c.Dispute=1  and  c.DeliveryDate between @FromDate and  @ToDate) as Dispute,
 
       CASE m.IsATNo WHEN 0 THEN 'CP' ELSE 'LP' END AS LPCP,  
       
    (Case( CASE m.Late WHEN 1 THEN 1 else  CASE m.Dispute WHEN 1 THEN  1 else 0 end end) when 0  
    then  
   ( CASE m.Status WHEN 0 THEN 'Processing' ELSE 'Completed' END)  
   else (  CASE m.Late WHEN 1 THEN 'Late' else '' end + CASE m.Dispute WHEN 1 THEN  'Dispute' else '' end)  
  END)             
      AS StatusFinal,  
      pm.Product_Name as Product,pm.productUnit as AU,m.Quantity,  
      0 as BalanceQty, 0 as SppiledQty,m.Value,     
      m.LDPer as LDAmount,m.Rate as StandingAmt,  m.AddedOn as Dated,           
     m.* from tblLPCP  m  
    inner join ProductMaster pm on pm.Product_ID =m.ProductId  
    inner join [OriginalManufacture ] om on om.Id=m.OriginalMfgID  
    inner join supplier sp on sp.Id=m.SupplierID  
    where    m.DeliveryDate between @FromDate and  @ToDate
    --m.DeliveryDate>@FromDate and m.DeliveryDate< @ToDate
    end
    
      
      
end       




END


GO
/****** Object:  StoredProcedure [dbo].[spManageBatch]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[spManageBatch]
@Action Varchar(50)=null,
@Id int=null
AS
BEGIN
if(@Action='SelectQty')
	begin
		select Quantity from StockMaster where BID=@Id;
	End
END


GO
/****** Object:  StoredProcedure [dbo].[spManageStock]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================              
-- Author:  <Author,,Ravi>              
-- Create date: <Create 05-12-2014,,>              
-- Description: <AddUser Insertion,selection updation>              
-- =============================================              
              
              
              
CREATE PROCEDURE [dbo].[spManageStock]              
 -- Add the parameters for the stored procedure here              
  @BID int=null,             
  @PID int=null,            
  @SID int=null,            
  @DepotID int=null,            
  @MFGDate datetime=null,            
  @EXPDate datetime=null,             
  @RecievedFrom varchar(50)=null,            
  @IsActive bit =null,               
  @IsStockIn bit=0,            
  @IsDeleted bit=0,            
  @MinQuantity varchar(1000)=null,            
  @Quantitytype varchar(50)=null,            
  @Quantity varchar(max)=null,            
  @BatchName varchar(50)=null,            
  @BatchCode varchar(50)=null,            
  @BatchDesc varchar(max)=null,            
  @AddedOn datetime=null,              
  @AddedBy int=null,              
  @ModifiedOn datetime=null,                
  @ModifiedBy int=null,              
  @Action varchar(100)=null,          
  @ESL datetime=null,          
  @BatchNo  varchar(50)=Null,          
  @ATNo  varchar(50)=Null,          
  @VechicleNo  varchar(50)=Null,         
  @Output int=0 output  ,        
  @Stockqty numeric(18,0)=null ,        
  @IsProductStatus varchar(50)=null,        
  @IsSentto bit =null   ,     
  @Productname VARCHAR(50)=NULL ,     
  @Stockqtyrem numeric(18,0)=null,
  @SupplierId int=null,
  @GenericName varchar(50)=null,
  @OriginalManf varchar(50)=null,
  @SentQty numeric(18,0)=null,
  @RecievedOn datetime=null,
  @DriverName varchar(50)=null,
  @InterTransferId int=null,
  @Remarks varchar(max)=null,
  @ChallanOrIrNo varchar(100)=null,
  @IsChallanNo bit=null,
  @IsIrNo bit=null,
  @PackingMaterial varchar(100)=null,
  @IsSampleSent int=null,
  @UnitInfo varchar(100)=null
          
AS              
BEGIN              
 -- SET NOCOUNT ON added to prevent extra result sets from              
 -- interfering with SELECT statements.              
 if(@Action = 'InsertBatch')              
 begin              
 insert into BatchMaster(BatchName,BatchCode,BatchDesc,BatchNo,ATNo,VechicleNo,RecievedFrom,PID,MFGDate,EXPDate,ESL,IsActive,AddedOn,IsDeleted,DepotID,IsSentto,IsBatchStatus)values              
                      (@BatchName,@BatchCode,@BatchDesc,@BatchNo,@ATNo,@VechicleNo,@RecievedFrom ,@PID,@MFGDate
                      ,@EXPDate,@ESL,@IsActive,GETDATE(),'false',@DepotID ,'false',@IsSampleSent);              
 set @Output =SCOPE_IDENTITY();          
      
  -- if((Select StockQty  from ProductMaster where Product_ID=@PID) is null and (Select  IsProductStatus from ProductMaster where Product_ID=@PID) is null)        
 if((Select StockQty  from ProductMaster where Product_ID=@PID) is null)     
begin        
--select @qty         
update ProductMaster set StockQty= @Stockqty,IsProductStatus=@IsProductStatus where Product_ID=@PID         
--update ProductMaster set StockQty=StockQty+ @qty where Product_ID=@id        
end        
else        
begin        
update ProductMaster set StockQty=StockQty+@Stockqty,IsProductStatus=@IsProductStatus where Product_ID=@PID        
--select @id         
end        
             
   return @Output              
           
   end              
               
   if(@Action = 'Insertstock')              
 --begin              
 --insert into StockMaster(Quantity,MinQuantity,BID, IsStockIn,IsActive,AddedOn)values              
 --                     (@Quantity,@MinQuantity,@BID,@IsStockIn,@IsActive,GETDATE());              
 --set @Output =SCOPE_IDENTITY();              
 --  return @Output              
 --  end            
 -- statically  minimum quantity enetered from backend            
             
 begin              
 insert into StockMaster(Quantity,MinQuantity,QuantityType,BID, IsStockIn,IsActive,AddedOn
 ,SupplierId,GenericName
 ,OriginalManf,SentQty,RecievedOn,DriverName,InterTransferId,Remarks,ChallanOrIrNo,IsChallanNo,IsIrNo,PackingMaterial
 ,UnitInfo)values              
                      (@Quantity,0,@Quantitytype,@BID,@IsStockIn,@IsActive,GETDATE(),@SupplierId,@GenericName
 ,@OriginalManf,@SentQty,@RecievedOn,@DriverName,@InterTransferId,@Remarks,@ChallanOrIrNo,@IsChallanNo,@IsIrNo,
 @PackingMaterial,@UnitInfo);              
 set @Output =SCOPE_IDENTITY();              
   return @Output              
   end            
             
             
  if(@Action = 'DropDisplay')            
  begin            
  select * from ProductMaster where IsActive=1            
 -- select * from CategoryMaster where IsActive=1            
  end              
 ----  if(@Action = 'GetDepot')              
 ---- begin              
 ---- select * from DepuMaster where IsActive='true'               
 ------ select * from CategoryMaster where IsActive=1              
 ---- end              
  if(@Action = 'griddisplay')              
  begin              
 ---- select * from UnitMaster un inner join DepuMaster dp on dp.Depu_Id=un.Depu_Id               
 -- --select * from UserMaster;            
 --select * from ProductMaster             
 --Select pro.Product_ID, pro.Product_Name,stock.MinQuantity,batch.BatchName,batch.BatchDesc,batch.BatchCode,pro.Product_Code,batch.MFGDate,batch.EXPDate,stock.Quantity             
 --from  ProductMaster pro            
 -- inner join BatchMaster batch on batch.PID=pro.Product_ID              
 --  inner join StockMaster stock on stock.BID=batch.BID            
       
	   select     
	   (SELECT QT.QuantityType FROM QuantityType AS QT WHERE QT.Id=sm.QuantityType) AS QuantityTypeNAME,    
	   (select rec.RecievedFrom from RecievedFrom as rec where rec.Id=bm.RecievedFrom) as RecievedFromname,
	  *,sp.Name AS SupplierName ,sp.Id AS SupplierId from BatchMaster bm            
	  inner join ProductMaster pm on pm.Product_ID=bm.PID            
	  inner join StockMaster sm on sm.BID=bm.BID 
	  left join supplier sp on sp.Id=sm.SupplierId        
	  where bm.IsActive=1 order by bm.AddedOn            
	  
   end             
              
              
 ---- if(@Action = 'datadisplay')              
 ---- begin              
 ---- --select um.*  ,dm.Depu_Name,unm.Unit_Name,rm.Role_Code             
 ---- --from UserMaster um             
 ---- --inner join DepuMaster dm on dm.Depu_Id=um.User_Depot            
 ---- --inner join UnitMaster unm on unm.Unit_Id=um.User_Unit            
 ---- --inner join RoleMaster rm on rm.Role_ID=um.User_Rank            
              
 ---- -- where um.IsActive=1            
 ---- --select * from UserMaster;            
 ------ select * from CategoryMaster where IsActive=1              
             
             
 ----  select *,(Select Depu_Name from DepuMaster where   Convert(varchar(50), Depu_Id)=UserMaster.User_Depot) As Depu_Name             
 ----       ,(Select Unit_Name from UnitMaster where  Convert(varchar(50), Unit_Id)= UserMaster.User_Unit) as Unit_Name            
 ----       ,(Select Role_Code from RoleMaster where  Convert(varchar(50),Role_ID)=UserMaster.User_Rank) as Role_Code            
 ----       from UserMaster where IsActive=1            
                    
             
             
 ---- end              
                
                
                
   if(@Action='Updatebatch')              
   begin              
   update BatchMaster set BatchName=@BatchName,BatchDesc=@BatchDesc,BatchNo=@BatchNo,PID=@PID,ATNo=@ATNo,VechicleNo=@VechicleNo,EXPDate=@EXPDate,Esl=@ESL,RecievedFrom=@RecievedFrom,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy  
    where  BID=@BID        
       
     if((Select StockQty  from ProductMaster where Product_ID=@PID) is null)     
 begin        
 --select @qty     
  update StockMaster set Quantity=convert(decimal,@Quantity),QuantityType=@Quantitytype,IsStockIn=@IsStockIn,BID=@BID,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  SID=@SID            
     update ProductMaster set StockQty = StockQty + convert(decimal,@Quantity) where Product_ID=@PID      
 --update ProductMaster set StockQty=StockQty+ @qty where Product_ID=@id        
 end        
 else        
 begin        
   if exists(select * From StockMaster where SID=@SID and Quantity=CONVERT(Decimal,@Quantity))    
   begin    
     update StockMaster set Quantity=convert(decimal,@Quantity),QuantityType=@Quantitytype,IsStockIn=@IsStockIn,BID=@BID,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  SID=@SID            
     --update ProductMaster set StockQty =StockQty  where Product_ID=@PID      
   end    
  else     
   begin    
    if exists(select * From StockMaster where SID=@SID and Quantity > CONVERT(Decimal,@Quantity))    
   begin    
   set @Stockqtyrem=convert(decimal,(select Quantity From StockMaster where SID=@SID)) - CONVERT(Decimal,@Quantity)    
       
   update StockMaster set Quantity=convert(decimal,@Quantity),QuantityType=@Quantitytype,IsStockIn=@IsStockIn,BID=@BID,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  SID=@SID            
       
   update ProductMaster set StockQty=StockQty-@Stockqtyrem  where Product_ID=@PID     
       
   end    
     else    
      begin    
      set @Stockqtyrem= convert(decimal,@Quantity) - convert(decimal,(select Quantity From StockMaster where SID=@SID))     
        
    update StockMaster set Quantity=convert(decimal,@Quantity),QuantityType=@Quantitytype,IsStockIn=@IsStockIn,BID=@BID,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  SID=@SID            
        
    update ProductMaster set StockQty=StockQty+@Stockqtyrem where Product_ID=@PID     
      end    
   end    
      
 --select @id         
 end       
     
 end              
  if(@Action='UpdateStock')              
   begin              
   update StockMaster set Quantity = convert(decimal,@Quantity),QuantityType=@Quantitytype,IsStockIn=@IsStockIn,BID=@BID,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy 
   ,SupplierId=@SupplierId,GenericName=@GenericName
 ,OriginalManf=@OriginalManf,SentQty=@SentQty,RecievedOn=@RecievedOn,DriverName=@DriverName,
 InterTransferId=@InterTransferId,Remarks=@Remarks,ChallanOrIrNo=@ChallanOrIrNo,IsChallanNo=@IsChallanNo,IsIrNo=@IsIrNo
 ,PackingMaterial=@PackingMaterial
   where  SID=@SID            
 end             
             
 if(@Action='updateactive')              
   begin              
   update BatchMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  BID=@BID                 
              
 end              
 ----if(@Action = 'GetUnitByDID')              
 ---- begin              
 ---- select * from UnitMaster where Depu_Id=@Depu_Id and IsActive='true'               
 ------ select * from CategoryMaster where IsActive=1              
 ---- end         
       
  IF(@Action='SelectQuantityType')      
 begin      
  select * from Quantitytype WHERE ISACTIVE=1      
 end          
     
  IF(@Action='GetProduct')      
 begin      
   if (@Productname='')    
  begin    
  SELECT * from ProductMaster WHERE IsActive=1    
  end    
 else    
  begin    
  SELECT * from ProductMaster WHERE IsActive=1 and Product_Name LIKE '%'+ @Productname +'%'    
 end     
 end
 
 IF(@Action='SelectRecievedFrom')      
 begin      
	select * From RecievedFrom where isactive=1    
 end    
          
END


GO
/****** Object:  StoredProcedure [dbo].[spProduct]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Ravi>      
-- Create date: <Create 05-12-2014,,>      
-- Description: <AddUser Insertion,selection updation>      
-- =============================================      
      
      
      
CREATE PROCEDURE [dbo].[spProduct]      
 -- Add the parameters for the stored procedure here      
  @Product_ID int=null,     
  @Product_Name varchar(50)=null,    
  @Product_Desc varchar(500)=null,    
  @Short_Product_Desc varchar(200)=null,    
  @Admin_remarks varchar(50)=null,    
  @Product_Cost int=null,    
  @Product_Code varchar(50)=null,     
  @IsActive bit =null,    
  @Category_Id int=null,       
  @AddedOn datetime=null,      
  @AddedBy int=null,      
  @ModifiedOn datetime=null,      
  @ModifiedBy int=null,     
  @StockQty numeric(18,0)=null,   
  @Action varchar(100)=null,       
  @Output int=null output,      
  @cat varchar(max)=null,
  @ProductUnit varchar(100)=null  ,
  @GSServe numeric(18,0)=null
       
       
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 if(@Action = 'Insert')      
 begin      
 if exists(select * from ProductMaster where Category_Id=@Category_Id   
 and (ltrim(rtrim(lower((Product_Name))))) = ((ltrim(rtrim(lower(@Product_Name))))))  
   begin  
    set @Output =-1     
   return @Output   
   end  
  else  
   begin  
  insert into ProductMaster(Product_Name,Product_Desc,Short_Product_Desc,Admin_Remarks,Product_Cost,Category_Id,Product_Code,StockQty,IsActive,AddedBy,  
  AddedOn,IsProductStatus,cat,productUnit,GSreservre)values      
                      (@Product_Name,@Product_Desc,@Short_Product_Desc,@Admin_remarks,@Product_Cost,@Category_Id,@Product_Code, @StockQty,@IsActive,  
                      @AddedBy,GETDATE(),'Pending',@cat,@ProductUnit,@GSServe);      
  set @Output =SCOPE_IDENTITY();      
   return @Output   
   end  
   end      
  if(@Action = 'griddisplay')      
  begin      
     
-- select * from ProductMaster    
     
 select *,(Select cp.Category_Name from CategoryMaster cp where cp.ID=cm.Category_Id) as Category    
      
   from ProductMaster cm       
     
  end      
       
  if(@Action = 'datadisplay')      
  begin      
  --select um.*  ,dm.Depu_Name,unm.Unit_Name,rm.Role_Code     
  --from UserMaster um     
  --inner join DepuMaster dm on dm.Depu_Id=um.User_Depot    
  --inner join UnitMaster unm on unm.Unit_Id=um.User_Unit    
  --inner join RoleMaster rm on rm.Role_ID=um.User_Rank    
      
  -- where um.IsActive=1    
  --select * from UserMaster;    
 -- select * from CategoryMaster where IsActive=1      
     
     
   --select *,(Select Depu_Name from DepuMaster where   Convert(varchar(50), Depu_Id)=UserMaster.User_Depot) As Depu_Name     
   --     ,(Select Unit_Name from UnitMaster where  Convert(varchar(50), Unit_Id)= UserMaster.User_Unit) as Unit_Name    
   --     ,(Select Role_Code from RoleMaster where  Convert(varchar(50),Role_ID)=UserMaster.User_Rank) as Role_Code    
   --     from UserMaster where IsActive=1    
            
 Select * from CategoryMaster   
  end      
   if(@Action='Update')      
   begin     
     
  if exists(select * from ProductMaster where Category_Id=@Category_Id AND Product_ID!=@Product_ID  
 and (ltrim(rtrim(lower((Product_Name))))) = ((ltrim(rtrim(lower(@Product_Name))))))  
   begin  
  set @Output =-1     
    return @Output   
   end  
  else  
   BEGIN  
   update ProductMaster set Product_Name=@Product_Name,Product_Desc=@Product_Desc,Short_Product_Desc=@Short_Product_Desc,Admin_Remarks=@Admin_remarks,product_cost=@Product_Cost,Category_Id=@Category_Id,IsActive=@IsActive  
        ,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy,cat=@cat ,productUnit=@ProductUnit,GSreservre  =@GSServe
        ,StockQty=@StockQty
        where  Product_ID=@Product_ID    
   set @Output =@Product_ID    
     return @Output  
   END  
 end      
 if(@Action='updateactive')      
   begin      
   update ProductMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  Product_ID=@Product_ID      
 end      
 if(@Action = 'UpdateQty')      
 begin      
update ProductMaster set StockQty=StockQty+@StockQty where Product_ID=@Product_ID  
 end      
END


GO
/****** Object:  StoredProcedure [dbo].[spRole]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Ravi>  
-- Create date: <Create 06-12-2014,>  
-- Description: <Insertion,Update of Role>  
-- =============================================  
  
CREATE PROCEDURE [dbo].[spRole]  
 -- Add the parameters for the stored procedure here  
 @Role_Id int=0,  
 @Role_Code varchar(50)=null,  
 @Role varchar(50)=null,
 @Role_Desc varchar(500)=null,  
 @IsActive bit =0,  
 @AddedOn datetime=null,  
 @AddedBy int=null,  
 @ModifiedOn datetime=null,  
 @ModifiedBy int=null,  
 @Action varchar(100)=null,
 @DeptId int=null,
 @Rank int=null,  
 
 @Output int=0 output  
   
   
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 if(@Action = 'Insert')  
 begin  
 insert into RoleMaster(Role,Role_Code,Role_Desc,IsActive,AddedOn,DeptId,Rank)values  
 (@Role,@Role_Code,@Role_Desc,@IsActive,GETDATE(),@DeptId,@Rank);  
 set @Output =SCOPE_IDENTITY();  
   return @Output  
   end  
   if(@Action = 'Griddisplay')  
  begin  
  select Dept=DeptName+' ('+DeptCode+') ',* from RoleMaster rl
   inner join DeptMaster dm on dm.Id=rl.DeptId order by rl.Rank --where rl.IsActive=1
 -- select * from CategoryMaster where IsActive=1  
  end  
   if(@Action='Update')  
   begin  
   update RoleMaster set Role=@Role,Role_Code=@Role_Code,Role_Desc=@Role_Desc,ModifiedBy=@ModifiedBy,IsActive=@IsActive, ModifiedOn=GETDATE(),DeptId=@DeptId,Rank=@Rank where Role_ID=@Role_Id  
 end  
  if(@Action='updateactive')  
   begin  
   update RoleMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  Role_Id=@Role_Id  
 end  
END    
   
   
   --select Role_Id from RoleMaster where Role_Id=(select max(Role_Id) from  RoleMaster)
   
   --select RoleCode=Role+'('+Role_Code+')', * from RoleMaster where DeptId=1 and IsActive=0  
   
   
   --select * from CountryMaster where IsActive=1
   --   select * from StatesMaster where IsActive=1 and CountryID=2
   --      select * from CityMaster where IsActive=1 and StateID=1743


GO
/****** Object:  StoredProcedure [dbo].[spselectcrv]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spselectcrv]  
(  
   @fromdate datetime=null  
  ,@todate datetime=Null  
)  
  
as  
  if((CONVERT(Date,@fromdate))=(convert(DATE,@todate)))
  begin
    select BID,AddedOn as dateofreceipt,BatchCode as crvno,VechicleNo    
		 ,(select rec.RecievedFrom from RecievedFrom as rec where rec.Id=BatchMaster.RecievedFrom) as RecievedFromname
		 ,(select pm.Product_Name From ProductMaster AS pm where pm.Product_ID=BatchMaster.PID) as ProductName
		 ,(select qt.QuantityType from QuantityType as qt
	      left join StockMaster as sm on sm.BID=Id where sm.QuantityType=qt.Id) AS QuantityTypeNAME
		,(select SM.Quantity From StockMaster AS SM WHERE SM.BID=BatchMaster.BID) AS Quantity
 		 ,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
		 ,Esl AS ESLDATE  ,EXPDate,BatchName,BatchDesc  
		 ,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
		 case WHEN Esl<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'    
		 from BatchMaster WHERE AddedOn>=@fromdate 
	 --AND AddedOn<=@todate  
   end
  ELSE
	BEGIN
	 select BID,AddedOn as dateofreceipt,BatchCode as crvno,VechicleNo    
		 ,(select rec.RecievedFrom from RecievedFrom as rec where rec.Id=BatchMaster.RecievedFrom) as RecievedFromname
		 ,(select pm.Product_Name From ProductMaster AS pm where pm.Product_ID=BatchMaster.PID) as ProductName
		 ,(select qt.QuantityType from QuantityType as qt
		   left join StockMaster as sm on sm.BID=Id where sm.QuantityType=qt.Id) AS QuantityTypeNAME
	     ,(select SM.Quantity From StockMaster AS SM WHERE SM.BID=BatchMaster.BID) AS Quantity
 		 ,RecievedFrom as fromwhomreceived,ATNo as atnodate ,BatchNo,MFGDate    
		 ,Esl AS ESLDATE  ,EXPDate,BatchName,BatchDesc  
		 ,CASE WHEN EXPDate<=GETDATE() THEN 'EXPIRE' ELSE     
		 case WHEN Esl<=GETDATE() THEN 'ESL' ELSE 'Normal' END END as 'ProductStatus'    
		 from BatchMaster WHERE AddedOn>=@fromdate AND AddedOn<=@todate  
	 END


GO
/****** Object:  StoredProcedure [dbo].[spSelectTranfer]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      



-- Author:  <Author,,Name>      



-- Create date: <Create Date,,>      



-- Description: <Description,,>      



-- =============================================      



CREATE PROCEDURE [dbo].[spSelectTranfer]      



 @Action varchar(50)=null,      



 @IssuOrderID int=null,      



 @id int=null,      



 @ProductID int =null,      



 @BatchNo varchar(50)=null,      



 @CatID int =null      



 AS      



BEGIN      



 -- SET NOCOUNT ON added to prevent extra result sets from      



 -- interfering with SELECT statements.      



 SET NOCOUNT ON;      



       



       



 if(@Action='GetVehiclebyBatch')      



   begin      


    DECLARE @IDTId int

	SELECT @IDTId=ID FROM tbl_IssueOrder where issueorderid=@IssuOrderID

  select (bm.CostOfParticular*td.StockQuantity)as VCost ,(bm.WeightofParticular*td.StockQuantity)as VWeight ,*   



  from tblIssueVoucherVehicleDetail td  



  inner join BatchMaster bm on bm.BID=td.BID  



   where td.Cat_ID=@CatID and td.issueorderID=@IDTId and td.ProductId=@ProductID      



   end      



 if(@Action='GetIDT')      



   begin      



  select * from tbl_batchIdt where  BatchName=@BatchNo and ProductID=@ProductID      



   end      



      



   if(@Action='GetIDTQtyByIssueOrderIDCase13')      



   begin      



    select top 2(select BatchNo from BatchMaster where BID=Batchid) as BatchNo,@ProductID as ProductID,* from  IDTStockTransfer      



   where       



 IDTId=(select top 1 Id from tbl_batchIdt where Issueorderid=@IssuOrderID and ProductID=@ProductID and BatchName=@BatchNo)       



     order by Dated desc      



   end      



    



 if(@Action='GetIDTQtyByIssueOrderIDCase245')      



   begin      



      



   select top 1(select BatchNo from BatchMaster where BID=Batchid) as BatchNo,@ProductID as ProductID,* from  IDTStockTransfer      



   where       



 IDTId=(select top 1 Id from tbl_batchIdt where Issueorderid=@IssuOrderID and ProductID=@ProductID and BatchName=@BatchNo)     



      order by Dated desc      



          



 --     select top 1(select BatchNo from BatchMaster where BID=Batchid) as BatchNo,16 as ProductID,* from  IDTStockTransfer      



 --  where       



 --IDTId=(select top 1 Id from tbl_batchIdt where Issueorderid=16 and ProductID=16 and BatchName='case4')  and PackingType <>'Full'  and PackingType<>'Loose'    



 --     order by Dated desc      



   end      



        



END






GO
/****** Object:  StoredProcedure [dbo].[spStock]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- =============================================      
CREATE PROCEDURE [dbo].[spStock]      
 -- Add the parameters for the stored procedure here      
 @Id int =null,      
 @IDs varchar(max)=null,      
 --*****************Stock      
 @SID int =null,      
 @IsChallanNo int =null,      
 @IsIrNo int =null,      
 @Weight decimal(18,3)=null,      
@ATNo varchar(max)= null,      
@SupplierNo varchar(max)= null,      
@CRVNo varchar(max)= null,      
@RecievedFrom varchar(50) =null,      
@PMGradeId int =null,      
@PMCapacityId int =null,      
@PMConditionId int =null,      
@OtherSupplier varchar(50) =null,      
@TransferedBy varchar(50) =null,      
@SampleSent bit =null,      
@ContactNo varchar(50) =null,      
@ChallanOrIR varchar(50)= null,      
@ChallanOrIRNo varchar(50) =null,      
@ProductId int =null,      
@OriginalMfg varchar(50) =null,      
@GenericName varchar(50) =null,      
@CostOfParticular decimal (18,2) =null,      
@RecievedDate datetime =null,      
@PackagingMaterialName varchar(max) =null,      
@PackagingMaterialShape varchar(50)=null,      
@PackagingMaterialSize varchar(50) =null,      
@PackagingMaterialFormatLevel decimal (18,3) =null,      
@Remarks varchar(200) =null,      
@AddedBy int =null,      
@AddedOn datetime =null,      
@Session datetime =null,      
@ModifiedBy int =null,      
@ModifiedOn datetime =null,      
@PackingMaterialFormat varchar(max) =null,      
@WeigthUnit varchar(50) =null,      
@ShapeUnit varchar(50) =null,      
@IsEmptyPM bit =0,      
@IsWithoutPacking int =0,      
      
@IsSubPacking bit =0,      
@IsDW bit =0,      
@SubPMName varchar(MAX)  =null,      
@SubPMGradeId int  =null,      
@SubPMCapacityId int  =null,      
@SubPMConditionId int  =null,      
@SubPMShape varchar(50)  =null,      
@SubPMSize varchar(50)  =null,      
@SubWeight decimal(18, 3)  =null,      
@SubWeightUnit varchar(50)  =null,      
@SubShapeUnit varchar(50)  =null,      
--*****************Stock Batch      
@BID int=null,      
@StockId int =null,      
@BatchNo varchar(50) =null,      
@WarehouseNo varchar(500) =null,      
@MfgDate datetime =null,      
@ExpiryDate datetime =null,      
@ESLDate datetime =null,      
@Cost decimal (36,2)=null,      
@SampleSentQty decimal (36,18)=null,      
@BWeight decimal (36,18)=null,      
@WeightofParticular decimal (36,18)=null,      
@WeightUnit varchar(50)=null,      
      
@WarehouseID int  =null,      
@SectionID int  =null,      
@SectionRows int  =null,      
@SectionCol int  =null,      
----@SampleSent bit, already exists in Stock Table      
--*****************Stock Vehicle      
      
--@StockID      
@DriverName varchar(50) =null,      
@VehicleNo varchar(50) =null,      
@StockBatchId int =null,      
@SentQty decimal (18,3)=null,      
@RecievedQty decimal (18,3)=null,      
@ChallanNo varchar(50)=null,      
@IsDDOrCHT varchar(50)=null,      
--*****************Stock Sppilage      
--StockId      
--StockBatchId      
@SpilledQty decimal (36,18) =null,      
@DamagedBoxes decimal (36,0)=null,      
@SpillageAffected decimal (36,0) =null,      
@SampleAffected decimal (36,0)=null,      
@BothAffected decimal (36,0) =null,      
      
--*****************Stock Packaging      
      
@PackagingType varchar(50) =null,      
--@StockBatchId      
@RemainingQty decimal (18,3)=null,      
@Format varchar(50) =null,      
      
 @Action varchar(100)=null,      
 @Output int=0 output        
AS      
BEGIN      
create table #Batch      
(      
tId int,      
tStockId int,      
tBatchId int,      
tSentQty decimal (36,18),      
tRecQty decimal (36,18),      
tSpilqty decimal (36,18)      
)      
create table #FinalBatch      
(      
tId int,      
tStockId int,      
tBatchId int,      
tSentQty decimal (36,18),      
tRecQty decimal (36,18),      
tSpilqty decimal (36,18)      
)      
 DECLARE       
@tCount int=0,      
@tBID int=0,      
@tSqty decimal (18,3)=0,      
@tRqty decimal (18,3) =0      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;      
 if(@Action = 'SelectPMList')        
 begin      
 select sm.SID,sm.PackingMaterial,sm.Quantity,0 as PMQty, sm.SubPMName,      
(select Unit from PMCapacity where Id= sm.SubPMCapacityId) as SubCapacity,      
 (select Grade from PMGrade where Id= sm.SubPMGradeId) as SubGrade,      
(select Condition from PMCondition where Id= sm.SubPMConditionId) as SubCondition,      
(select Unit from PMCapacity where Id= sm.PMCapacityId) as Capacity,      
(select Grade from PMGrade where Id= sm.PMGradeId) as Grade,      
(select Condition from PMCondition where Id= sm.PMConditionId) as Condition,      
(select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
(select Product_Name from ProductMaster where Product_ID= sm.ProductId) as Product_Name,      
(select Category_Name from CategoryMaster where ID= (select top 1 Category_Id from ProductMaster where Product_ID=sm.ProductId)) as Cat,      
sm.IsEmptyPM,sm.IsDW,sm.IsSubPacking,sm.RecievedOn,sm.AddedOn      
      
  from StockMaster sm  --where  sm.SID=9      
 where  sm.Quantity>0 and sm.IsWithoutPacking=0  and sm.CRVNo<>''       
       
  end      
       
 if(@Action = 'DeleteOnSppilageUpdate')        
 begin       
       
delete from  StockPakaging where StockBatchId in (select BID from BatchMaster where StockId=@SID  )      
 end      
 if(@Action = 'DeleteOnUpdate')        
 begin       
 delete from StockSpillage where StockId=@SID       
delete from  StockPakaging where StockBatchId in (select BID from BatchMaster where StockId=@SID  )      
 end      
 if(@Action = 'DeleteStockIn')        
 begin       
 delete from StockMaster where SID=@SID      
 end      
 if(@Action = 'InsertStockIn')        
 begin       
 insert into StockMaster      
 (Session,IssueQty,IsSubPacking ,      
IsDW ,      
SubPMName ,      
SubPMGradeId ,      
SubPMCapacityId ,      
SubPMConditionId ,      
SubPMShape ,      
SubPMSize ,      
SubWeight ,      
SubWeightUnit ,      
SubShapeUnit ,       
 IsEmptyPM,      
IsWithoutPacking ,      
 PMGradeId ,      
PMCapacityId ,      
PMConditionId ,ShapeUnit,WeigthUnit,Weight,SupplierNo,Quantity,ATNo,RecievedFrom,OtherSupplier,TransferedBy,ProductId,OriginalManf,CostOfParticular,RecievedOn,PackingMaterial,PackagingMaterialShape,PackagingMaterialSize,PackingMaterialFormat,PackagingMaterialFormatLevel,Remarks,AddedBy,AddedOn,IsActive)values        
 (@Session,0,@IsSubPacking ,      
@IsDW ,      
@SubPMName ,      
@SubPMGradeId ,      
@SubPMCapacityId ,      
@SubPMConditionId ,      
@SubPMShape ,      
@SubPMSize ,      
@SubWeight ,      
@SubWeightUnit ,      
@SubShapeUnit ,@IsEmptyPM ,      
@IsWithoutPacking,@PMGradeId ,      
@PMCapacityId ,      
@PMConditionId ,@ShapeUnit,@WeigthUnit,@Weight,@SupplierNo,0,@ATNo,@RecievedFrom,@OtherSupplier,@TransferedBy,@ProductId,@OriginalMfg,@CostOfParticular,@RecievedDate,@PackagingMaterialName,@PackagingMaterialShape,@PackagingMaterialSize,@PackingMaterialFormat,@PackagingMaterialFormatLevel,@Remarks,@AddedBy,GETDATE(),1);        
 set @Output =SCOPE_IDENTITY();        
   return @Output        
   end       
 if(@Action = 'UpdateStockIn')        
 begin       
 Update StockMaster set Session=@Session, IsSubPacking=@IsSubPacking ,      
IsDW=@IsDW ,      
SubPMName=@SubPMName ,      
SubPMGradeId=@SubPMGradeId ,      
SubPMCapacityId=@SubPMCapacityId ,      
SubPMConditionId=@SubPMConditionId ,      
SubPMShape=@SubPMShape ,      
SubPMSize=@SubPMSize ,      
SubWeight=@SubWeight ,      
SubWeightUnit=@SubWeightUnit ,      
SubShapeUnit=@SubShapeUnit , IsEmptyPM =@IsEmptyPM,      
IsWithoutPacking =@IsWithoutPacking,      
PMGradeId=@PMGradeId ,      
PMCapacityId =@PMCapacityId,      
PMConditionId=@PMConditionId ,ATNo=@ATNo,RecievedFrom=@RecievedFrom,OtherSupplier=@OtherSupplier,TransferedBy=@TransferedBy,      
 ShapeUnit=@ShapeUnit,WeigthUnit=@WeigthUnit,Weight=@Weight,SupplierNo=@SupplierNo,ProductId=@ProductId,OriginalManf=@OriginalMfg,      
 CostOfParticular=@CostOfParticular,RecievedOn=@RecievedDate,PackingMaterial=@PackagingMaterialName,      
 PackagingMaterialShape=@PackagingMaterialShape,PackagingMaterialSize=@PackagingMaterialSize,PackingMaterialFormat=@PackingMaterialFormat,      
 PackagingMaterialFormatLevel=@PackagingMaterialFormatLevel,Remarks=@Remarks,ModifiedBy=@AddedBy,ModifiedOn=GETDATE(),IsActive=1      
 where SID=@SID         
   end       
   if(@Action = 'UpdateCRV')        
 begin       
 set @tCount=(select COUNT(*) from StockMaster where CRVNo=@CRVNo and SID=@SID)      
 if(@tCount>0)      
 begin      
 set @Output=1      
 return @Output      
  end      
  else      
  begin      
declare @Exist int =0      
set @Exist=(select COUNT(*) SID from StockMaster where ProductId=(select p.ProductId from StockMaster p where p.SID=@SID) and CRVNo=@CRVNo)--(select c.CRVNo from StockMaster c where c.SID=@SID))      
  if(@Exist>0)      
  begin      
 set @Output=0      
 return @Output      
  end      
  else      
  begin      
 Update StockMaster set CRVNo=@CRVNo where SID=@SID       
 set @Output=@SID      
 end      
 return @Output        
   end  end      
   if(@Action = 'SelectAll')        
 begin       
  select        
  'April-'+(CONVERT(VARCHAR(4),YEAR(sm.session)))+ ' to March-'+(CONVERT(VARCHAR(4),YEAR(sm.session)+1)) as Session,      
  sm.Quantity as PMQty, sm.PackingMaterial as PMName, sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
   as SubPackingMaterial,      
  sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
   as PackingMaterial,      
   ISNULL(sm.SupplierNo,'false')  as SupplierNo,      
   ISNULL(sm.ATNO,'false')  as ATNO,      
  ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo)  as ATSONo,      
 (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
 (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
 (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
 (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
  (sm.CostOfParticular*sm.Quantity) as Amount,      
  (sm.CRVNo+','+CONVERT(VARCHAR(11), sm.ProductId)) as CRVPrint,       
  * from StockMaster sm      
 where sm.CRVNo<>''      
   end       
 if(@Action = 'SelectByCRVNo')        
 begin       
      
 select       
 (select ct.ID from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as CatID,      
 sm.SupplierId,      
 sm.SubPMShape,sm.SubPMSize,sm.SubShapeUnit,sm.SubWeight,sm.SubWeightUnit,      
 sm.PackingMaterial as PMName,      
 sm.IsEmptyPM,sm.IsWithoutPacking,      
 sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
   as SubPackingMaterial,      
sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
   as PackingMaterial,      
 sm.SupplierNo,      
   sm.ATNO,      
 ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo)  as ATSONo,      
 (sm.CostOfParticular*sm.Quantity) as Amount,      
  (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
 (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
 (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
 (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
 sm.Quantity, sm.BID,sm.OriginalManf,sm.OtherSupplier,sm.PackagingMaterialFormatLevel,sm.PackagingMaterialShape,sm.PackagingMaterialSize,      
 sm.PackingMaterial,sm.PackingMaterialFormat,sm.RecievedFrom,      
 ISNULL('['+ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO +'] ' +sm.Remarks ,'['+ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo+'] ' +sm.Remarks) as Remarks,      
  sm.ShapeUnit,sm.TransferedBy,sm.Weight,sm.WeigthUnit      
  ,sm.SID,sm.CostOfParticular,sm.CRVNo,sm.AddedOn ,sm.RecievedOn,sm.IsSubPacking,sm.IsDW ,sm.Remarks as Remarks1,sm.SubPMName as SUBPMName from StockMaster sm      
 --where sm.CRVNo='101' and sm.ProductId in(select pp.Product_ID from ProductMaster pp where pp.Category_Id=(select c.Category_Id from ProductMaster c where c.Product_ID=39))      
 where sm.CRVNo=@CRVNo and sm.ProductId in(select pp.Product_ID from ProductMaster pp where pp.Category_Id=(select c.Category_Id from ProductMaster c where c.Product_ID=@ProductId))      
   end       
      
if(@Action = 'Select')        
 begin       
 ----select * from StockMaster where SID=@SID      
 --select * from CategoryMaster      
       
 --select * from ProductMaster      
       
 select sm.PackingMaterial as PMName,      
 sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
   as SubPackingMaterial,      
sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
   as PackingMaterial,      
sm.SupplierNo,      
   sm.ATNO,      
 ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo) as ATSONo,      
 (sm.CostOfParticular*sm.Quantity) as Amount,      
  (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
 (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
 (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
 (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
 sm.Quantity, sm.BID,sm.OriginalManf,sm.OtherSupplier,sm.PackagingMaterialFormatLevel,sm.PackagingMaterialShape,sm.PackagingMaterialSize,      
 sm.PackingMaterial,sm.PackingMaterialFormat,sm.RecievedFrom,sm.Remarks,sm.ShapeUnit,sm.TransferedBy,sm.Weight,sm.WeigthUnit      
  ,sm.SID,sm.CostOfParticular,sm.CRVNo,sm.AddedOn ,sm.* from StockMaster sm      
      
      
      
 where sm.SID=@SID       
   end       
        
        
  if(@Action = 'SelectMultiple')        
 begin       
       
-- select       
-- sm.PackingMaterial as PMName,      
-- sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
--  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
--   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
--   as SubPackingMaterial,      
-- sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
--  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
--   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
--   as PackingMaterial,      
-- ISNULL(sm.SupplierNo,'false')  as SupplierNo,      
--   ISNULL(sm.ATNO,'false')  as ATNO,      
-- ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo)  as ATSONo,      
-- (sm.CostOfParticular*sm.Quantity) as Amount,      
-- (select ct.ID from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as CatID,      
--  (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
-- (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
-- (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
-- (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
--  * from StockMaster sm      
--where sm.SID in(select * from Split(@IDs,','))      
-- --where sm.SID in(2,3,4)      
 select       
 (select ct.ID from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as CatID,      
 sm.SupplierId,      
 sm.SubPMShape,sm.SubPMSize,sm.SubShapeUnit,sm.SubWeight,sm.SubWeightUnit,      
 sm.PackingMaterial as PMName,      
 sm.IsEmptyPM,sm.IsWithoutPacking,      
 sm.SubPMName +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.SubPMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.SubPMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.SubPMConditionId),'')      
   as SubPackingMaterial,      
sm.PackingMaterial +ISNULL((select top 1 (' '+Unit) as Data from pmcapacity where Id=sm.PMCapacityId),'')      
  +ISNULL((select top 1 (' '+ Grade) from PMGrade where Id=sm.PMGradeId),'')      
   +ISNULL((select top 1 (' '+ Condition) from PMCondition where Id=sm.PMConditionId),'')      
   as PackingMaterial,      
 sm.SupplierNo,      
   sm.ATNO,      
 ISNULL(ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO  ,ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo)  as ATSONo,      
 (sm.CostOfParticular*sm.Quantity) as Amount,      
  (select ct.Category_Name from CategoryMaster ct where ct.ID=(select top 1 pm.Category_Id from ProductMaster pm where pm.Product_ID=sm.ProductId)) as Cat,      
 (select pm.productUnit from ProductMaster pm where pm.Product_ID=sm.ProductId) as AU,      
 (select pm.Product_Name from ProductMaster pm where pm.Product_ID=sm.ProductId) as ITEMS,      
 (select pm.Short_Product_Desc from ProductMaster pm where pm.Product_ID=sm.ProductId) as GenericName,      
 sm.Quantity, sm.BID,sm.OriginalManf,sm.OtherSupplier,sm.PackagingMaterialFormatLevel,sm.PackagingMaterialShape,sm.PackagingMaterialSize,      
 sm.PackingMaterial,sm.PackingMaterialFormat,sm.RecievedFrom,      
 ISNULL('['+ISNULL(sm.SupplierNo,'AT No: ')+sm.ATNO +'] ' +sm.Remarks ,'['+ISNULL(sm.ATNO,'SO No: ')+sm.SupplierNo+'] ' +sm.Remarks) as Remarks,      
       
 sm.ShapeUnit,sm.TransferedBy,sm.Weight,sm.WeigthUnit      
  ,sm.SID,sm.CostOfParticular,sm.CRVNo,sm.AddedOn ,sm.RecievedOn,sm.IsSubPacking,sm.IsDW,sm.Remarks as Remarks1,sm.SubPMName as SUBPMName  from StockMaster sm      
      
where sm.SID in(select * from Split(@IDs,','))      
       
   end        
        
   if(@Action = 'SelectBatch')        
 begin       
 select * from BatchMaster where BID=@BID      
   end       
    if(@Action = 'SelectBatchByStock')        
 begin       
 Select         
(select SUM(sv.RecievedQty) from StockVehicle sv where sv.StockBatchId=bm.BID) as QTY, * from BatchMaster bm      
       
  where StockId=@StockId       
  order by bm.MFGDate,bm.Esl,bm.EXPDate,bm.CostOfParticular      
       
      
   end      
    if(@Action = 'SelectBatchByVehicle')        
 begin      
 --select * from BatchMaster bm where bm.StockId=17 and bm.BID not in (select sv.StockBatchId from StockVehicle sv where sv.StockID=17)      
       
   select * from batchmaster bm where bm.StockId=@StockId and bm.BID not in      
   (select sv.StockBatchId from StockVehicle sv       
   where sv.StockID=@StockId and sv.DriverName=@DriverName and sv.VehicleNo=@VehicleNo )      
end      
      
      
   if(@Action = 'SelectVehicle')        
 begin       
 select (select BatchNo from BatchMaster where BID=s.StockBatchId) as BatchNo ,      
 s.DriverName+' ['+s.VehicleNo+']' as Vehicle,      
 * from StockVehicle s where s.Id=@Id      
   end       
    if(@Action = 'SelectVehicleByStock')        
 begin       
         
    select (  select BatchNo from BatchMaster where BID=sv.StockBatchId) as BatchNo,      
    sv.DriverName+' ['+sv.VehicleNo+']' as Vehicle,      
     sv.* from StockVehicle sv      
     where sv.StockId=@StockId       
     order by sv.ChallanNo      
            
       
   end      
    if(@Action = 'SelectVehicleNoByStock')        
 begin       
         
       
      select distinct sv.VehicleNo from StockVehicle sv      
     where sv.StockId= @StockId       
     --where sv.StockId= 8037      
       
   end      
   if(@Action = 'SelectVehicleByBatch')        
 begin       
         
    select sv.*, sv.DriverName+' ['+sv.VehicleNo+']' as Vehicle,(select BatchNo from BatchMaster where BID=sv.StockBatchId) as BatchNo from StockVehicle sv where      
     sv.StockBatchId=@StockBatchId and sv.StockId=(select bm.StockId from BatchMaster bm where bm.BID=@StockBatchId)      
     -- sv.StockId=@StockId      
   end      
   if(@Action = 'SelectSpillageByStockBatch')        
 begin      
       
 select * from StockSpillage where StockBatchId=@StockBatchId and StockId=@StockId      
 --select * from StockSpillage where  StockId=3      
 end      
 if(@Action = 'SelectPackingFull')        
 begin      
       
       
       
 select * from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID      
 where bm.StockId=@StockId and  sp.PackagingType='Full'      
       
       
       
 end      
  if(@Action = 'SelectPackingById')        
 begin      
 select (select bm.BatchNo from BatchMaster bm where sp.StockBatchId=bm.BID) as BatchNo,* from  StockPakaging sp       
 where  sp.Id=@Id      
       
 end      
       
       
 if(@Action = 'SelectPackingLoose')        
 begin      
 select * from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID      
 where bm.StockId=@StockId and  sp.PackagingType='Loose'      
       
      
       
 end      
     if(@Action = 'SelectIfSpillageByStock')        
 begin      
 insert into #Batch select Id,StockID,StockBatchId,SentQty,RecievedQty,0 from StockVehicle where StockId=@StockId order by StockBatchId       
      
set @tCount= (select COUNT(*) from #Batch)      
insert into #FinalBatch select top 1 *  from #Batch      
update #FinalBatch set tSpilqty=(select top 1 (tSentQty)  from #FinalBatch order by tId desc)-(select top 1 (tRecQty)  from #FinalBatch order by tId desc)--(select top 1 (tRecQty)  from #FinalBatch)-(select top 1 (tSentQty)  from #FinalBatch)      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
set @tBID =(select top 1 (tBatchId)  from #FinalBatch order by tId desc)      
while(@tCount>0)      
begin      
if(@tBID=(select top 1 (tBatchId)  from #Batch))      
begin      
update #FinalBatch set tSentQty=(tSentQty+(select top 1 (tSentQty)  from #Batch)),tRecQty=(tRecQty+(select top 1 (tRecQty)  from #Batch)),tSpilqty=(tSentQty+(select top 1 (tSentQty)  from #Batch)) -(tRecQty+(select top 1 (tRecQty)  from #Batch))      
where tBatchId=@tBID      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
end      
else      
begin      
insert into #FinalBatch select top 1 *  from #Batch      
update #FinalBatch set tSpilqty=(select top 1 (tSentQty)  from #FinalBatch where tId =(select top 1 (tId)  from #Batch)) -(select tRecQty  from #FinalBatch where tId =(select top 1 (tId)  from #Batch) )      
where  tId =(select top 1 (tId)  from #Batch)      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
end      
set @tBID =(select top 1 (tBatchId)  from #FinalBatch order by tId desc)      
set @tCount= (select COUNT(*) from #Batch)      
end      
 select (select tRecQty from #FinalBatch where tBatchId=s.StockBatchId) as tRecQty,(select tSentQty from #FinalBatch where tBatchId=s.StockBatchId) as tSentQty,(select BatchNo from BatchMaster where BID=s.StockBatchId) as BatchNo,(Select SampleSentQty from BatchMaster where BID=s.StockBatchId) as SampleSentQty, (Select IsSentto from BatchMaster where BID=s.StockBatchId) as IsSentto, * from StockSpillage s where s.StockId=@StockId      
       
 end      
   if(@Action = 'SelectSpillageByStock')        
 begin       
       
insert into #Batch select Id,StockID,StockBatchId,SentQty,RecievedQty,0 from StockVehicle where StockId=@StockId order by StockBatchId       
set @tCount= (select COUNT(*) from #Batch)      
insert into #FinalBatch select top 1 *  from #Batch      
update #FinalBatch set  tSpilqty=(select top 1 (tSentQty)  from #FinalBatch)-(select top 1 (tRecQty)  from #FinalBatch)--(select top 1 (tRecQty)  from #FinalBatch)-(select top 1 (tSentQty)  from #FinalBatch)      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
set @tBID =(select top 1 (tBatchId)  from #FinalBatch)      
while(@tCount>0)      
begin      
if(@tBID=(select top 1 (tBatchId)  from #Batch))      
begin      
update #FinalBatch set tSentQty=(tSentQty+(select top 1 (tSentQty)  from #Batch)),tRecQty=(tRecQty+(select top 1 (tRecQty)  from #Batch)),tSpilqty=(tSentQty+(select top 1 (tSentQty)  from #Batch)) -(tRecQty+(select top 1 (tRecQty)  from #Batch))      
where tBatchId=@tBID      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
end      
else      
begin      
insert into #FinalBatch select top 1 *  from #Batch      
update #FinalBatch set tSpilqty=(select top 1 (tSentQty)  from #FinalBatch where tId =(select top 1 (tId)  from #Batch)) -(select tRecQty  from #FinalBatch where tId =(select top 1 (tId)  from #Batch) )      
where  tId =(select top 1 (tId)  from #Batch)      
delete from #Batch where tId=(select top 1 (tId)  from #Batch)      
end      
set @tBID =(select top 1 (tBatchId)  from #FinalBatch order by tId desc)      
set @tCount= (select COUNT(*) from #Batch)      
end      
select (Select IsSentto from BatchMaster where BID=f.tBatchId) as IsSentto,isnull((Select SampleSentQty from BatchMaster where BID=f.tBatchId),0) as SampleSentQty, (Select BatchNo from BatchMaster where BID=f.tBatchId) as BatchNo, * from #FinalBatch f    
  
      
--drop table #Batch      
--drop table #FinalBatch      
      
      
   end      
    if(@Action = 'SelectDWPacking')        
 begin         
        
       
   select          
      REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 105), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo END AS Contact,      
   sp.*,bm.* from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID and sp.PackagingType='DW'       
 where bm.StockId=@StockId order by sp.PackagingType      
 --where bm.StockId=3       
-- order by bm.BID      
  --order by sp.PackagingType      
 end    
  if(@Action = 'SelectPackingByCRVNo')        
 begin         
           select    
  isnull(sm.PackingMaterial,'') as PM,
   isnull(sm.SubPMName,'') as SUBPM,               
      REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 105), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo END AS Contact,      
   sp.*,bm.* from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID   
inner join stockmaster sm on sm.SID=bm.StockId   
 where bm.StockId in (select SID from StockMaster  where CRVNo=@CRVNo and ProductId=@ProductId)
 -- where bm.StockId in (select SID from StockMaster  where CRVNo='1' and ProductId=1)
 order by  sm.SID
  
       
      
 end    
   if(@Action = 'SelectPackingBySIDs')        
 begin         
           select    
  isnull(sm.PackingMaterial,'') as PM,
   isnull(sm.SubPMName,'') as SUBPM,               
      REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 105), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo END AS Contact,      
   sp.*,bm.* from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID   
inner join stockmaster sm on sm.SID=bm.StockId   
 where bm.StockId  in(select * from Split(@IDs,','))     
 order by  sm.SID
  
       
      
 end       
   if(@Action = 'SelectPacking')        
 begin         
        
       
   select  
   
   
           
      REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 105), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo END AS Contact,      
   sp.*,bm.* from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID   
inner join stockmaster sm on sm.SID=bm.StockId  
 where bm.StockId=@StockId order by sp.PackagingType      
 --where bm.StockId=3       
-- order by bm.BID      
  --order by sp.PackagingType      
 end      
   if(@Action = 'SelectPackingByBatchID')        
 begin         
        
       
   select          
       -- (bm.BatchNo+'| MFG Date:'+ CONVERT(VARCHAR(12), bm.MFGDate, 107)+'| Exp Date:'+ISNULL((CONVERT(VARCHAR(12), bm.EXPDate, 107)),'N/A')+'| Esl Date:'+ISNULL((CONVERT(VARCHAR(12), bm.Esl, 107)),'N/A')) as Batch,       
        --+' Exp Date:'+ CONVERT(VARCHAR(12), bm.EXPDate, 107)+' Esl Date:'+ CONVERT(VARCHAR(12), bm.Esl, 107)) as Batch,       
 REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 105), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo END AS Contact,      
   sp.*,bm.* from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID where bm.BID=@BID order by sp.PackagingType      
 end      
         
         
     if(@Action = 'SelectCRVPRint')        
 begin         
        
      
   select          
        REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 106), ' ','-') AS MFGDate,       
    ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 106), ' ','-')),'N/A') as EXPDate,      
     ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-')),'N/A') as Esl,      
   CASE bm.IsSentto WHEN 0 THEN 'Not Sent' ELSE 'Sent to, Contact Info:'+bm.ContactNo      
       END AS Contact ,bm.BatchNo as BatchNo,*      
         from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID      
 where bm.StockId=@StockId order by sp.PackagingType      
 end      
         
       
       
    if(@Action = 'InsertStockBatchMaster')        
 begin        
 set @tCount=(select COUNT(*) from BatchMaster where BatchNo=@BatchNo and StockId=@StockId)      
 if(@tCount>0)      
 begin      
 set @Output=0      
 return @Output      
  end      
  else      
  begin      
 insert into BatchMaster(WarehouseID ,      
SectionID ,      
SectionRows,      
SectionCol ,SampleSentQty,StockId,BatchNo,MfgDate,EXPDate,Esl,IsSentto,ContactNo,Remarks,Cost,CostOfParticular,Weight,WeightofParticular,WeightUnit,WarehouseNo)values        
                       (@WarehouseID ,      
@SectionID ,      
@SectionRows,      
@SectionCol ,@SampleSentQty,@StockId,@BatchNo,@MfgDate,@ExpiryDate,@ESLDate,@SampleSent,@ContactNo,@Remarks,@Cost,@CostOfParticular,@BWeight,@WeightofParticular,@WeightUnit,@WarehouseNo);        
 set @Output =SCOPE_IDENTITY();        
   return @Output      
   end        
   end       
   if(@Action = 'UpdateStockBatchMaster')        
 begin        
 set @tCount=(select COUNT(*) from BatchMaster where BatchNo=@BatchNo and StockId=@StockId and BID<>@BID)      
 if(@tCount>0)      
 begin      
 set @Output=0      
 return @Output      
  end      
  else      
  begin      
 update  BatchMaster set WarehouseID=@WarehouseID ,      
SectionID=@SectionID ,      
SectionRows=@SectionRows,      
SectionCol=@SectionCol , SampleSentQty=@SampleSentQty,WarehouseNo=@WarehouseNo,Cost=@Cost,CostOfParticular=@CostOfParticular,Weight=@BWeight,WeightofParticular=@WeightofParticular,WeightUnit=@WeightUnit,Remarks=@Remarks,StockId=@StockId,BatchNo=@BatchNo, 
  
   
MfgDate=@MfgDate,EXPDate=@ExpiryDate,Esl=@ESLDate,IsSentto=@SampleSent,ContactNo=@ContactNo ,IsActive=1 where BID=@BID;        
 set @Output= @BID      
 return @Output      
 end      
   end       
    if(@Action = 'DeleteBatch')        
 begin      
 delete from BatchMaster where BID=@BID        
 delete from StockVehicle where StockBatchId=@BID      
 end      
 if(@Action = 'DeleteVehicle')        
 begin      
 delete from StockVehicle where Id=@Id        
 end      
    if(@Action = 'InsertStockVehicle')        
 begin       
  set @tCount=(select COUNT(*) from StockVehicle where StockBatchId=@StockBatchId and DriverName=@DriverName and VehicleNo=@VehicleNo and StockId=@StockId)      
 if(@tCount>0)      
 begin      
 set @Output=0      
 return @Output      
  end      
  else      
  begin       
 insert into StockVehicle(StockID,DriverName,VehicleNo,StockBatchId,SentQty ,RecievedQty,ChallanNo,IsDDOrCHT)values        
 (@StockID,@DriverName,@VehicleNo,@StockBatchId,@SentQty ,@RecievedQty,@ChallanNo,@IsDDOrCHT);        
 set @Output =SCOPE_IDENTITY();        
   return @Output        
   end      
   end       
    if(@Action = 'UpdateStockVehicle')        
        
  begin       
  set @tCount=(select COUNT(*) from StockVehicle where StockBatchId=@StockBatchId and DriverName=@DriverName and VehicleNo=@VehicleNo and StockId=@StockId and Id<>@Id)      
 if(@tCount>0)      
 begin      
 set @Output=0      
 return @Output      
  end      
  else      
  begin        
 update StockVehicle set IsDDOrCHT=@IsDDOrCHT,ChallanNo=@ChallanNo,StockID=@StockID,DriverName=@DriverName,VehicleNo=@VehicleNo,StockBatchId=@StockBatchId,SentQty=@SentQty ,RecievedQty=@RecievedQty where Id=@Id      
   set @Output=@Id      
 return @Output      
  end      
   end       
    if(@Action = 'InsertStockSpillage')        
 begin       
   set @tCount=(select COUNT(*) from StockSpillage where StockId=@StockId and StockBatchId=@StockBatchId)      
   if(@tCount>0)      
  begin      
  set @Output=(select top 1 Id from StockSpillage where StockId=@StockId and StockBatchId=@StockBatchId)      
  update StockSpillage set SpilledQty=@SpilledQty, DamagedBoxes=@DamagedBoxes,SpillageAffected=@SpillageAffected,SampleAffected=@SampleAffected,BothAffected=@BothAffected where Id=@Output      
  --delete from StockPakaging where StockBatchId in(select BID from BatchMaster where StockId=@StockId)      
  return @Output      
  end      
  else       
  begin      
 insert into StockSpillage(StockId,StockBatchId,SpilledQty,DamagedBoxes,SpillageAffected,SampleAffected,BothAffected)values        
 (@StockId,@StockBatchId,@SpilledQty,@DamagedBoxes,@SpillageAffected,@SampleAffected,@BothAffected);        
 set @Output =SCOPE_IDENTITY();        
 --delete from  StockPakaging where StockBatchId in (select BID from BatchMaster where StockId=@StockId  )      
  end      
   set @IsWithoutPacking=(select top 1 IsWithoutPacking from StockMaster where sid=@StockId)      
   set @IsEmptyPM=(select top 1 IsEmptyPM from StockMaster where sid=@StockId)      
   if(@IsWithoutPacking= 1)      
   begin      
   --Update Stock      
  update StockMaster set Quantity=(select sum(sv.RecievedQty) from StockVehicle sv      
   where sv.StockBatchId in (select BID from BatchMaster where StockId=@StockId)) where SID=@StockId      
     end      
    if(@IsEmptyPM= 1)      
   begin      
       --Update Stock      
  update StockMaster set Quantity=(select sum(sv.RecievedQty) from StockVehicle sv       
  where sv.StockBatchId in (select BID from BatchMaster where StockId=@StockId)) where SID=@StockId      
       end       
return @Output        
         
   end       
    if(@Action = 'InsertStockPakaging')        
 begin        
  set @tCount=(select COUNT(*) from StockPakaging where PackagingType=@PackagingType and  StockBatchId=@StockBatchId)      
   if(@tCount>0)      
  begin      
  set @Output=(select top 1 Id from StockPakaging where PackagingType=@PackagingType and StockBatchId=@StockBatchId)      
  update StockPakaging set RemainingQty=@RemainingQty,Format=@Format where Id=@Output      
  --Update Stock      
  update StockMaster set Quantity=(select sum(sp.RemainingQty) from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID where bm.StockId=(select b.StockId from BatchMaster b where b.BID=@StockBatchId)) where SID=(select b.StockId from BatchMaster b where b.BID=@StockBatchId)      
       
  return @Output      
  end      
  else      
  begin      
 insert into StockPakaging(PackagingType,StockBatchId,RemainingQty,Format)values        
 (@PackagingType,@StockBatchId,@RemainingQty,@Format);       
 --Updating stock qty      
 update StockMaster set Quantity=(select sum(sp.RemainingQty) from BatchMaster bm      
inner join StockPakaging sp on sp.StockBatchId=bm.BID where bm.StockId=(select b.StockId from BatchMaster b where b.BID=@StockBatchId)) where SID=(select b.StockId from BatchMaster b where b.BID=@StockBatchId)      
      
set @Output =SCOPE_IDENTITY();        
   return @Output        
   end end      
         
       
       
END




GO
/****** Object:  StoredProcedure [dbo].[SpStock_StockIn]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SpStock_StockIn]                   
(@DateOfReceipt date,                            
 @CrvNumber varchar,    
 @Description varchar,
 @ReceivedFrom  varchar,
 @PackingMaterialName varchar,
 @OriginalManufacture varchar,
 @GenericName varchar,
 @Weight decimal,
 @AddedBy int,
 @@AddedOn date,
 @ModifiedBy int,
 @ModifiedOn date,
 @BatchName varchar,
 @Quantity int,
 @WarehouseSectionId varchar,
 @MfgDate date,
 @ExpDate date,
 @EslDate date
)                            
As                                     
BEGIN     
		Declare @BatchId int        
			INSERT INTO Stock_BatchMaster (BatchName,Quantity,WarehouseSectionId,MfgDate,ExpDate,EslDate) Values (@BatchName,@Quantity,@WarehouseSectionId,@MfgDate,@ExpDate,@EslDate)  
			Set @BatchId = scope_Identity()  
		    
			Insert Stock_StockIn(LotBatchId,DateOfReceipt,CrvNumber,Description,ReceivedFrom,PackingMaterialName,OriginalManufacture,GenericName,Weight,AddedBy,AddedOn,ModifiedBy,ModifiedOn) Values
			(@BatchId,@DateOfReceipt,@CrvNumber,   
 @Description,
 @ReceivedFrom,
 @PackingMaterialName,
 @OriginalManufacture,
 @GenericName,
 @Weight,
 @AddedBy,
 @@AddedOn,
 @ModifiedBy,@ModifiedOn)
 
		End  
          


GO
/****** Object:  StoredProcedure [dbo].[spUnit]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Ravi>
-- Create date: <Create 05-12-2014,,>
-- Description:	<UnitInsertion,selection updation>
-- =============================================



CREATE PROCEDURE [dbo].[spUnit]
 -- Add the parameters for the stored procedure here
 @Unit_id int=null,
 @Depu_id int=null,
 @Unit_name varchar(500)=null,
 
 @Unit_Desc varchar(Max)=null,
 @IsActive bit =0,
 @Unit_Code varchar(50)=null,
 @AddedOn datetime=0,
 @AddedBy int=0,
 @ModifiedOn datetime=0,
 @ModifiedBy int=0,
 @Action varchar(1000)=null, 
 @Output int=0 output,
  @Command int=0,
   @Formation int=0,
 @UnitType int=0
 
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 if(@Action = 'UnitCheckExist')
 begin
 select * from UnitMaster WHERE Unit_Name=@Unit_name
 -- interfering with SELECT statements.
 END
 if(@Action = 'Insert')
 begin
 insert into UnitMaster(Depu_id,Unit_Name,Unit_Desc,Unit_Code,IsActive,AddedOn,UnitType)values
 (@Depu_id,@Unit_name,@Unit_Desc,@Unit_Code,@IsActive,GETDATE(),@UnitType);
 set @Output =SCOPE_IDENTITY();
   return @Output
   end
   if(@Action = 'DropDisplay')
  begin
  select * from DepuMaster where IsActive='true' 
 -- select * from CategoryMaster where IsActive=1
  end
  if(@Action = 'griddisplay')
  begin
  select un.*,dp.*,cm.Name as CommandName,fm.Name as FormationName from UnitMaster un 
  inner join DepuMaster dp on dp.Depu_Id=un.Depu_Id 
   inner join formation fm on fm.id=dp.FormationId

  inner join CommandMaster cm on cm.id = fm.CommandId
   
 -- select * from CategoryMaster where IsActive=1
  end
  
  
   if(@Action='Update')
   begin
   update UnitMaster set Unit_name=@Unit_name,Unit_desc=@Unit_desc,IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy,
   UnitType=@UnitType where  Unit_Id=@Unit_id
	end
	if(@Action='updateactive')
   begin
   update UnitMaster set IsActive=@IsActive,ModifiedOn=GETDATE(),ModifiedBy=@ModifiedBy where  Unit_Id=@Unit_Id
	end
END


GO
/****** Object:  StoredProcedure [dbo].[spUnitById]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUnitById]
	@Action varchar(max)=null,
	 @Unit_name varchar(500)=null
AS
BEGIN
 select * from UnitMaster WHERE Unit_Name=@Unit_name
END


GO
/****** Object:  StoredProcedure [dbo].[spUpdateStockOnIDTDelete]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[spUpdateStockOnIDTDelete]
@SID int=0,
@idtID int=0,
@Quantity decimal(18,3)=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
   update StockMaster set IssueQty=IssueQty-@Quantity where SID=@SID
   delete from IDTStockTransfer where IDTId=@idtID
   delete from tbl_batchIdt where id=@idtID
   
END


GO
/****** Object:  StoredProcedure [dbo].[spUser]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Ravi>    
-- Create date: <Create 05-12-2014,,>    
-- Description: <AddUser Insertion,selection updation>    
-- =============================================    
    
    
    
CREATE PROCEDURE [dbo].[spUser]    
 -- Add the parameters for the stored procedure here    
   
 @User_Id int=null,  
 @FirstName varchar(50)=null,  
 @UserCode varchar(50)=null,  
 @LastName varchar(50)=null,  
 @User_name varchar(50)=null,  
 @RoleId int=null,    
 @Country int=null,  
 @State int=null,  
 @City int=null,  
 @Address varchar(200)=null,  
 @ContactNo varchar(50)=null,  
 @Password varchar(50)=null,  
 @IsActive int =0,     
 @AddedOn datetime=0,    
 @AddedBy int=0,    
 @ModifiedOn datetime=0,    
 @ModifiedBy int=0,    
 @Action varchar(100)=null,     
 @Output int=0 output   ,
  @StartDate datetime=0,   
  @EndDate datetime=0,
  @ArmyNo varchar(50)=null   
   
   
     
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 if(@Action = 'Insert')    
 begin    
 insert into UserMaster(UserCode,FirstName,LastName,User_Name,RoleId,Password,Country,State,City,Address,ContactNo,IsActive,Addedon,AddedBy,ArmyNo,StartDate
 ,EndDate)values    
                      (@UserCode,@FirstName,@LastName,@User_Name,@RoleId,@Password,@Country,@State,@City,@Address,@ContactNo,@IsActive,GETDATE(),@AddedBy,
                      @ArmyNo,@StartDate,@EndDate);    
 set @Output =SCOPE_IDENTITY();    
   return @Output    
   end    
    --Added by Ravi  
   if(@Action = 'GetDepot')    
  begin    
  select * from DepuMaster where IsActive='true'     
  end    
   
  --if(@Action = 'griddisplay')  
   if(@Action = 'datadisplay')    
  begin    
  select Name=FirstName+' '+LastName,
  (select Role=rm.Role+'('+rm.Role_Code+')' from RoleMaster rm where rm.Role_ID=um.RoleId) as Role ,
  (select CountryName from CountryMaster cn where cn.ID=um.Country) as CountryName,
  (select SUName from StatesMaster sm where sm.ID=um.State) as StateName,
   (select CityName from CityMaster ct where ct.ID=um.City) as CityName,
  um.* from UserMaster um
  
  end    
   --End Added By Ravi  
if(@Action = 'Update')    
  begin    
  Update UserMaster set UserCode=@UserCode,FirstName=@FirstName,LastName=@LastName,User_Name=@User_Name,RoleId=@RoleId,Password=@Password,Country=@Country,
  State=@State,City=@City,Address=@Address,ContactNo=@ContactNo,IsActive=@IsActive  ,ArmyNo=@ArmyNo,StartDate=@StartDate,EndDate=@EndDate
  where User_Id=@User_Id  
  end    
      
    if(@Action = 'SelectAll')    
  begin    
  select * from UserMaster um  
  inner join RoleMaster rm on rm.Role_ID=um.RoleId  
  inner join CountryMaster cm on cm.ID=um.country  
  inner join StatesMaster sm on sm.ID=um.State  
  inner join CityMaster ct on ct.ID=um.City  
    
  end    
 if(@Action = 'SelectActive')    
  begin    
  select * from UserMaster um  
  inner join RoleMaster rm on rm.Role_ID=um.RoleId  
  inner join CountryMaster cm on cm.ID=um.country  
  inner join StatesMaster sm on sm.ID=um.State  
  inner join CityMaster ct on ct.ID=um.City  
  where um.IsActive=1  
  end    
END      
     
     
    
    --select User_Id from UserMaster where User_Id=(select max(User_Id) from  UserMaster)


GO
/****** Object:  StoredProcedure [dbo].[usp_add_update_Authority]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_add_update_Authority]
(
@Auid int,
@Auname varchar(500),
@userId int=null,
@active bit,
@Fyear int,
@OrderType int,
@Qid int



)
AS
BEGIN

if(@Auid = 0)

BEGIN
insert into tbl_Authority values (@Auname,@active,@Fyear,@Qid,@OrderType,GETDATE(),GETDATE(),@userId,@userId)
END

else

BEGIN
Update tbl_Authority set AuthorityName=@Auname ,modifieddate=GETDATE(),modifieduserid=@userId,Active=@active,Fyear=@Fyear,Qid=@Qid,OrderType=@OrderType where Auid=@Auid 

END

END


GO
/****** Object:  StoredProcedure [dbo].[usp_Autogenrate_LoadTallyNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Autogenrate_LoadTallyNumber]    
(    
@vechileNo nvarchar(max),    
@IssueorderId int    
)    
As    
Begin    
declare @loadtallyno as nvarchar(max),@i int,@categoryname  varchar(200),@loadtallyID int, @datetime varchar(500), @output1 int ,    
@nextLoadtallyNumber as nvarchar(max),@increamentedseed as int,@count int    
    
select  @loadtallyID=(select max(id) from tbl_loadtaly)    
    
select @loadtallyno=loadtallyNumber  from tbl_loadtaly where id=@loadtallyID    
    
select @datetime=(SELECT CONVERT(VARCHAR(30),GETDATE(),105) AS DateConvert)    
    
select @count=count(1) from tbl_loadtaly    
    
if(@count<>0)    
begin    
if not Exists(Select 1 from tbl_loadtaly where IssueorderId =@IssueorderId and vechileNo =@vechileNo And Active=1)     
begin    
exec [dbo].[proc_getSeedNumber]  @loadtallyno,@output1 OUTPUT    
set @increamentedseed=@output1+1    
    
set @nextLoadtallyNumber='LT'+'/'+convert(varchar(500),@increamentedseed)+' '+'DT'+@datetime    
    
Insert into tbl_loadtaly values(@nextLoadtallyNumber,@IssueorderId,@vechileNo,1,1,getdate(),1,getdate(),0,'')    
    
END    
END    
else if(@count=0)    
begin    
    
set @increamentedseed=1001    
set @nextLoadtallyNumber='LT'+'/'+convert(varchar(500),@increamentedseed)+' '+'DT'+@datetime    
    
Insert into tbl_loadtaly values(@nextLoadtallyNumber,@IssueorderId,@vechileNo,1,1,getdate(),1,getdate(),0,'')    
end    
    
    
    
else    
begin    
 update tbl_loadtaly set Modifieddate=getdate() where issueorderid=@IssueorderId and vechileNo =@vechileNo    
end    
    
    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CheckProductExsist]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_CheckProductExsist]
 (
 @Prdname varchar(200)
 )      
As           
Begin 
Declare @Exsit bit 
	Select @Exsit = count(1) from  ProductMaster where Product_Name=@Prdname and IsActive=1

	select @Exsit as result
End


GO
/****** Object:  StoredProcedure [dbo].[usp_creareIssueVoucherNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_creareIssueVoucherNumber]
(
 
@IssueorderId int,
@CatId int,
@ivNo varchar(50)

)

As
Begin
declare @issuevouchervalue as nvarchar(max),@i int,@categoryname  varchar(200),@issuevouchId int, @datetime varchar(500), @output1 int ,
@nextIssueVoucherNumber as nvarchar(max),@increamentedseed as int,@count int,@IssueorderNo nvarchar(max)
select  @issuevouchId=(select max(id) from tbl_issuevoucherdetail)

select @issuevouchervalue=IssusevoucherName from tbl_issuevoucherdetail where id=@issuevouchId

select @categoryname=Category_Name from CategoryMaster where id=@CatId

select @datetime=(SELECT CONVERT(VARCHAR(30),GETDATE(),105) AS DateConvert)
select @count=count(1) from tbl_issuevoucherdetail
if(@count<>0)
begin
if not Exists(Select 1 from tbl_issuevoucherdetail  where IssueorderId =@IssueorderId And Cat_ID=@CatId And Active=1) 
begin
--exec [dbo].[proc_getSeedNumber]  @issuevouchervalue,@output1 OUTPUT
--set @increamentedseed=@output1+1

set @nextIssueVoucherNumber=@categoryname+'/'+'IV'+'/'+convert(varchar(500),@ivNo)+' '+'DT'+@datetime

Insert into tbl_issuevoucherdetail values(@IssueorderId,@nextIssueVoucherNumber,1,getdate(),1,getdate(),1,@CatId)

END
END
else if(@count=0)
begin

--set @increamentedseed=1001
set @nextIssueVoucherNumber=@categoryname+'/'+'IV'+'/'+convert(varchar(500),@ivNo)+' '+'DT'+@datetime



Insert into tbl_issuevoucherdetail values(@IssueorderId,@nextIssueVoucherNumber,1,getdate(),1,getdate(),1,@CatId)
end



else
begin
 update tbl_issuevoucherdetail set Modifieddate=getdate() where issueorderid=@IssueorderId
end


END

--select * from tbl_issuevoucherdetail


GO
/****** Object:  StoredProcedure [dbo].[usp_createIssueOrderNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from tbl_issuevoucherdetail
--truncate table tbl_issuevoucherdetail
--exec [usp_createIssueOrderNumber] 2,43
CREATE proc [dbo].[usp_createIssueOrderNumber]
(
@intResult nvarchar(max) output 
)
As
Begin
declare @issueorderValue as nvarchar(max),@i int,@categoryname  varchar(200),@issueorderId int, @datetime varchar(500), @output1 int ,
@nextIssueOrderNumber as nvarchar(max),@increamentedseed as int,@count int

select  @issueorderId=(select max(IssueOrderId) from tbl_IssueOrder)

select @issueorderValue=IssueOrderNo from tbl_IssueOrder where IssueOrderId=@issueorderId


select @datetime=(SELECT CONVERT(VARCHAR(30),GETDATE(),105) AS DateConvert)
select @count=count(1) from tbl_IssueOrder
if(@count<>0)
begin

exec [dbo].[proc_getSeedNumber]  @issueorderValue,@output1 OUTPUT
set @increamentedseed=@output1+1

set @nextIssueOrderNumber='TEST'+'/'+'IO'+'/'+convert(varchar(500),@increamentedseed)+' '+'DT'+@datetime
set @intResult= @nextIssueOrderNumber
END
else if(@count=0)
begin

set @increamentedseed=1001
set @nextIssueOrderNumber='TEST'+'/'+'IO'+'/'+convert(varchar(500),@increamentedseed)+' '+'DT'+@datetime
set @intResult= @nextIssueOrderNumber

end




END


GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteIssuedVehicle]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[usp_DeleteIssuedVehicle] @Id INT = NULL
	,@Case INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from    
	-- interfering with SELECT statements.    
	SET NOCOUNT ON;

	DECLARE @Bid INT
	DECLARE @ProductId INT

	SELECT *
	FROM tblIssueVoucherVehicleDetail

	SELECT @Bid = bid
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	SELECT @ProductId = ProductId
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	DECLARE @IssueorderId INT

	SELECT @IssueorderId = issueorderid
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	DECLARE @StockQuantity DECIMAL(36, 11)
	DECLARE @FormatFull VARCHAR(MAX)
	DECLARE @FormatLoose VARCHAR(MAX)

	SELECT @StockQuantity = StockQuantity
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	SELECT @FormatFull = FormatFull
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	SELECT @FormatLoose = FormatLoose
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id

	UPDATE tbl_IssueOrder
	SET orderstatusid = 0
	WHERE productid = @ProductId
		AND IssueOrderId = @IssueorderId

	DECLARE @RowCount INT

	SELECT @RowCount = Count(*)
	FROM IDTStockTransfer
	WHERE IDTId = (
			SELECT TOP 1 Id
			FROM tbl_batchIdt
			WHERE Issueorderid = @IssueorderId
				AND ProductID = @ProductId
				AND BID = @Bid
			)

	IF (
			@Case = 1
			OR @Case = 3
			)
	BEGIN
		--delete from IDTStockTransfer where Id in(    
		--select top 2 (Id) from  IDTStockTransfer      
		--where IDTId=(select top 1 Id from tbl_batchIdt where Issueorderid=@IssueorderId and ProductID=@ProductId and BID=@Bid)       
		--  order by Dated desc ) 
		IF (@RowCount = 1)
		BEGIN
			UPDATE IDTStockTransfer
			SET CurrentQuantity = CurrentQuantity + @StockQuantity
			WHERE IDTId = (
					SELECT TOP 1 Id
					FROM tbl_batchIdt
					WHERE Issueorderid = @IssueorderId
						AND ProductID = @ProductId
						AND BID = @Bid
					)
		END
	END

	IF (
			@Case = 2
			OR @Case = 4
			OR @Case = 5
			)
	BEGIN
		--    delete from IDTStockTransfer where Id in(    
		--  select top 1 (Id) from  IDTStockTransfer   where       
		--IDTId=(select top 1 Id from tbl_batchIdt where Issueorderid=@IssueorderId and ProductID=@ProductId and BID=@Bid)       
		--     order by Dated desc )     
		IF (@RowCount = 1)
		BEGIN
			UPDATE IDTStockTransfer
			SET CurrentQuantity = CurrentQuantity + @StockQuantity
			WHERE IDTId = (
					SELECT TOP 1 Id
					FROM tbl_batchIdt
					WHERE Issueorderid = @IssueorderId
						AND ProductID = @ProductId
						AND BID = @Bid
					)
		END
	END

	DELETE
	FROM tblIssueVoucherVehicleDetail
	WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Dropdowngetcategory]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Dropdowngetcategory]  

as  
  
begin  
  
  select Id ,Category_Name from CategoryMaster where IsActive=1
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_DUMMYgrdbachwithproductqty]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_DUMMYgrdbachwithproductqty]

AS

BEGIN
DECLARE @batchID int


--select @batchID=BID from BatchMaster where batchcode=@BatchCode


select top 1 * from StockMaster 

END


GO
/****** Object:  StoredProcedure [dbo].[usp_GenrateIssueVoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GenrateIssueVoucher]  
(  
@catId int,  
@IssueVoucherNumber nvarchar(max)  
  
)  
  
  
AS  
  
BEGIN  
  
if  Exists(Select 1 from tblIssueVoucherVehicleDetail where cat_id=@catid And Active=1 and IssueVoucherId=@IssueVoucherNumber)  
  
BEGIN  
  
update tblIssueVoucherVehicleDetail set issueVoucher_status=1 where cat_id=@catid and IssueVoucherId=@IssueVoucherNumber  
  
  
END  
  
END


GO
/****** Object:  StoredProcedure [dbo].[usp_GenrateLoadTally]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GenrateLoadTally]        
(        
@issueorderID int,        
@vechileNo nvarchar(max),        
@Authority varchar(500),        
@through varchar(200),        
@loadtallyNo nvarchar(max),        
@driverName varchar(500),        
@rank varchar(200),        
@UnitNo varchar(200),    
@Userid int=null,        
@dateofgenration datetime ,
@Remarks varchar(max)=''       
        
)        
        
AS        
        
BEGIN        
        
      declare @loadtallyId int   
      select @loadtallyId=id from tbl_loadtaly where loadtallyNumber=@loadtallyNo    
        
if not Exists(Select 1 from tbl_loadtallydetail where IssueorderId =@IssueorderId and vechileNo =@vechileNo And Active=1)        
begin         
Insert into tbl_loadtallydetail values(@loadtallyNo,@issueorderID,@vechileNo,@driverName,@rank,@UnitNo,@dateofgenration,1,@Userid,getdate(),1,getdate(),@Authority,@through,@loadtallyId,@Remarks)        
      
update tbl_loadtaly set loadtally_status=1,Modifieddate=getdate() where loadtallyNumber=@loadtallyNo       
    update tbl_vechileMaster set loadtallystatus=1 where VechileNumber=@vechileNo     
end        
        
else        
        
begin        
update tbl_loadtallydetail set modifieddate=getdate() where IssueorderId =@IssueorderId and vechileNo =@vechileNo And Active=1        
      
update tbl_loadtaly set loadtally_status=1,Modifieddate=getdate() where id=@loadtallyId      
update tbl_vechileMaster set loadtallystatus=1 where VechileNumber=@vechileNo   
end         
        
END


GO
/****** Object:  StoredProcedure [dbo].[usp_get_Authority]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_get_Authority]
AS
BEGIN
select ta.*,tb.AttributeName as AttributeName from tbl_Authority ta inner join  tbl_Atttribute  tb on ta.OrderType =tb.TypeId
END


GO
/****** Object:  StoredProcedure [dbo].[usp_get_issueorder]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_get_issueorder]  
(  
@catId int  
)    
As    
Begin  
if(@catId!=0)  
begin    

select distinct IssueOrderNo ,IDTICTAWS,(select SUM(issuequantity)from [tbl_IssueOrder] where IssueOrderNo=iso.IssueOrderNo ) as issuequantity,
(select top 1 CreateDate from [tbl_IssueOrder] where IssueOrderNo=iso.IssueOrderNo ) as CreateDate,
pm.Category_Id as Category_Id,Authority,REPLACE(CONVERT(VARCHAR(11), issueorder_date, 105), ' ','-') AS issueorder_date,
(select Category_Name from CategoryMaster where ID=pm.Category_Id) as Category_Name,IssueOrderId,iso.OrderStatusId,
isnull((select top 1 issueVoucher_status from tblIssueVoucherVehicleDetail tb where tb.issueorderID=iso.IssueOrderId and tb.Cat_ID=pm.Category_Id),0) as IssueVoucherStatus ,
isnull((select top 1 IssueVoucherId from tblIssueVoucherVehicleDetail tb where tb.issueorderID=iso.IssueOrderId and tb.Cat_ID=pm.Category_Id),0) as IssueVoucherNo 

from  [tbl_IssueOrder] iso   
inner join productmaster pm on iso.productid=pm.product_id    
 inner join CategoryMaster cm on pm.Category_Id=cm.id 
 where cm.ID=@catId and iso.active=1  
End  
else  
begin  
select distinct IssueOrderNo ,IDTICTAWS,(select SUM(issuequantity)from [tbl_IssueOrder] where IssueOrderNo=iso.IssueOrderNo ) as issuequantity,
(select top 1 CreateDate from [tbl_IssueOrder] where IssueOrderNo=iso.IssueOrderNo ) as CreateDate,
pm.Category_Id as Category_Id,Authority,REPLACE(CONVERT(VARCHAR(11), issueorder_date, 105), ' ','-') AS issueorder_date,
(select Category_Name from CategoryMaster where ID=pm.Category_Id) as Category_Name,IssueOrderId,iso.OrderStatusId,
isnull((select top 1 issueVoucher_status from tblIssueVoucherVehicleDetail tb where tb.issueorderID=iso.IssueOrderId and tb.Cat_ID=pm.Category_Id),0) as IssueVoucherStatus ,
isnull((select top 1 IssueVoucherId from tblIssueVoucherVehicleDetail tb where tb.issueorderID=iso.IssueOrderId and tb.Cat_ID=pm.Category_Id),0) as IssueVoucherNo 

from  [tbl_IssueOrder] iso   
inner join productmaster pm on iso.productid=pm.product_id    
 inner join CategoryMaster cm on pm.Category_Id=cm.id  where iso.active=1  
end  
End


GO
/****** Object:  StoredProcedure [dbo].[usp_getAllloadtallyDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getAllloadtallyDetail]  
(  
@loadtallyNumberValue nvarchar(max)  
)  
  
AS  
  
BEGIN  
  
select * ,(Case isnull((select l.loadtally_status from tbl_loadtaly l where l.IssueorderId=issueorderID and l.loadtallyNumber=@loadtallyNumberValue),0)
when 0
then 1 else 0 end) as Status from tbl_loadtallydetail where loadtallyNumber=@loadtallyNumberValue and active=1  
  
  
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getattributeby_financialyear]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getattributeby_financialyear]

AS

begin

select TypeId,AttributeName from tbl_Atttribute where Active=1
end


GO
/****** Object:  StoredProcedure [dbo].[usp_GetAttributeName]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetAttributeName]
 (
 @Typeid int
 )      
As           
Begin  
   
	Select AttributeName from  tbl_Atttribute where TypeId=@Typeid and Active=1
End


GO
/****** Object:  StoredProcedure [dbo].[usp_getAuthorityDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_getAuthorityDetail]
(
@AuthorityId int
)
AS
BEGIN
select * from tbl_Authority where Auid=@AuthorityId
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getBatch]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getBatch]            
(         
@Action varchar(100)=null,           
@prdid int             
)            
as            
            
begin            
     create table #tempBatch(BID int,RemainingQty decimal(36,11), BatchNo varchar(500),batchcodeWithQty varchar(max))        
 if(@Action = 'WithPacking')          
 begin        
           
    insert into #tempBatch select  bm.BID,   
Case isnull(bm.SampleSentQty,0) when 0   
then   
  (select sum(s.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from StockPakaging s where s.StockBatchId=bm.BID)  
  else  
 isnull((select sum(ex.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),(select sum(s.RemainingQty) from StockPakaging s where s.StockBatchId=bm.BID))

    end  
  as RemainingQty1,      
          
    bm.BatchNo,        
(bm.BatchNo        
 +'['+         
  CASE ISNULL('ESL: '+(REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-'))+'|','') WHEN '' THEN ISNULL('Exp: '+(REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-'))+'|','') ELSE ISNULL('ESL: '+(REPLACE(CONVERT(VARCHAR(
  
    
4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-'))+'|','') end      
     + 'Qty: ' +           
      convert(varchar(max),  
      Case isnull(bm.SampleSentQty,0) when 0   
then   
      (select sum(s.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from StockPakaging s where s.StockBatchId=bm.BID)  
       else  
 isnull((select sum(ex.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),(select sum(s.RemainingQty) from StockPakaging s where s.StockBatchId=bm.BID))

    end  
      )        
      +']')as batchcodeWithQty   
     from BatchMaster bm           
 inner join StockPakaging sp on sp.StockBatchId=bm.BID          
where  bm.StockId in(select sm.SID from StockMaster sm where sm.ProductId=@prdid ) and sp.RemainingQty>0       
 order by bm.Esl,bm.EXPDate      
--where  bm.StockId in(select sm.SID from StockMaster sm where sm.ProductId=25) and sp.RemainingQty<>0          
        
select distinct * from  #tempBatch order by RemainingQty desc        
        
end        
if(@Action = 'WithoutPacking')          
 begin        
          
    insert into #tempBatch select  bm.BID, (select sum(s.RecievedQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  from StockVehicle s where s.StockBatchId=bm.BID) as RemainingQty1,bm.BatchNo,        
(bm.BatchNo        
 +'['+         
  CASE ISNULL('ESL: '+(REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-'))+'|','') WHEN '' THEN ISNULL('Exp: '+(REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 105), ' ','-'))+'|','') ELSE ISNULL('ESL: '+(REPLACE(CONVERT(VARCHAR(
  
    
4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-'))+'|','') end      
     + 'Qty: ' +convert(varchar(max),(select sum(s.RecievedQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  from StockVehicle s where s.StockBatchId=bm.BID))+']')as batchcodeWithQty        
             
      from BatchMaster bm           
 inner join StockVehicle sv on sv.StockBatchId=bm.BID          
where  bm.StockId in(select  sm.SID from StockMaster sm where sm.ProductId=@prdid and sm.Quantity-sm.IssueQty>0)         
   order by bm.Esl,bm.EXPDate      
        
select distinct * from  #tempBatch order by RemainingQty desc        
 end        
end         
        
        
--drop table #tempBatch


GO
/****** Object:  StoredProcedure [dbo].[usp_GetBatchquantity]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_GetBatchquantity]    
(    
@productID int,    
@issueorderid int    
)    
AS    
BEGIN    
    
select (select pd.Product_Name from ProductMaster pd where pd.Product_ID=dt.ProductID) as ProductName,   
(bm.WeightofParticular* dt.issueqty) as WeightOfBatch ,    
 * from tbl_batchIdt dt  
 inner join BatchMaster bm on bm.BID=dt.BID  
   
  where dt.issueorderid=@issueorderid and dt.ProductID=@productID    
   
   
     
    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getcategory]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_getcategory]

as

begin

select * from CategoryMaster where isactive=1

end


GO
/****** Object:  StoredProcedure [dbo].[usp_getcount]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getcount]  
(  
@productid int ,
@catID int,
@issueorderid int

)  
as  
begin  

declare @issuequantity decimal,@issuequantityVechile decimal
if  Exists(Select 1 from tblIssueVoucherVehicleDetail where cat_id=@catid And Active=1 and issueorderid=@issueorderid and productid=@productid)  
begin

select @issuequantity=issuequantity from tbl_IssueOrder where IssueOrderId=@issueorderid and productID=@productid

select @issuequantityVechile=sum(StockQuantity) from tblIssueVoucherVehicleDetail where  IssueOrderId=@issueorderid and productID=@productid

if(@issuequantity=@issuequantityVechile)
begin
 
select * from tblIssueVoucherVehicleDetail where cat_id=@catid And Active=1 and issueorderid=@issueorderid and productid=@productid  
end

else
begin
return 0
end
end
end


GO
/****** Object:  StoredProcedure [dbo].[usp_getcount_satus]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getcount_satus]  
(  
@productid int,  
@issueorderNumber nvarchar(max)  
)  
  
as  
  
begin  
  
select   issuevoucher_status from tblIssueVoucherVehicleDetail tv  
inner join tbl_issueorder ti on tv.productid=ti.productid and tv.issueorderid=ti.issueorderid  
where  ti.issueorderno=@issueorderNumber  
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_getdeatilIssuevoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getdeatilIssuevoucher]          
(          
@catid int ,
@issueorderid int          
          
)          
          
AS          
          
BEGIN          
          
select cm.Category_Name,* from [dbo].[tbl_IssueOrder] iso      
inner join productmaster pm on iso.productid=pm.product_id        
inner join CategoryMaster cm on pm.Category_Id=cm.id        
where pm.Category_Id=@catid and active=1 and issueorderid=@issueorderid     
          
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getDepuName]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_getDepuName]
(
@depuid int
)

as

begin

select * from depumaster where depu_id=@depuid and isactive=1

end


GO
/****** Object:  StoredProcedure [dbo].[usp_GetFinancialyear]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetFinancialyear]  

as  
  
begin  
  
  select distinct  YearRange,QuarterYear from tblQuarter 
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_GetIdtqty]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetIdtqty]      
(      
@depuId int,    
@productId int ,
@QuaterID int    
      
)      
      
as      
      
begin      
    
      
select product_name , TotalIDT,DepotId,ProductId from tblStockOutMain ts   
 inner join productmaster pm on ts.productid=pm.product_id where depotid=@depuId and ProductId=@productId  and ts.QuarterId=@QuaterID
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_getIssueIdtdetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_getIssueIdtdetail]
As

Begin

select TB.* , PM.Product_Name,DM.Depu_Name  from [tbl_batchIdt] TB inner join ProductMaster PM on TB.ProductID=PM.Product_ID
inner join DepuMaster DM on DM.Depu_Id=TB.DepuID order by 1 desc

End


GO
/****** Object:  StoredProcedure [dbo].[usp_getissuevoucherdetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getissuevoucherdetail]  

(  

@catid int,

@issueorderid int  

)  

  

as  

  

begin 

declare @IssueorderNo nvarchar(max)
declare @IDTId int

select @IssueorderNo=IssueOrderNo, @IDTId=ID from tbl_IssueOrder where issueorderid=@issueorderid

if  Exists(select 1 from tblIssueVoucherVehicleDetail a inner join ProductMaster b on  a.Cat_ID=b.Category_Id inner join 

tbl_IssueOrder tos on tos.productID=b.Product_ID where IssueOrderNo=@IssueorderNo)  



  

begin  

select distinct issuevoucherid,dateofgenration,through from tblIssueVoucherVehicleDetail where cat_id=@catid and issueorderid=@IDTId--@issueorderid

  

  end

end



--select * from tbl_IssueOrder inner join 

--select * from tblIssueVoucherVehicleDetail



--select 1 from tblIssueVoucherVehicleDetail a inner join ProductMaster b on  a.Cat_ID=b.Category_Id inner join 

--tbl_IssueOrder tos on tos.productID=b.Product_ID where IssueOrderNo='TEST/IO/1007 DT02-01-2016'


GO
/****** Object:  StoredProcedure [dbo].[usp_getIssueVoucherList]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getIssueVoucherList]        
As        
        
BEGIN        
        
--SELECT IssusevoucherName,sum(issuequantity)  as Qty,    
--(CASE WHEN tv.Active = 1 THEN 'Active' WHEN tv.Active = 0 THEN 'InActive' END)As Status1     
--FROM tbl_issuevoucherdetail tv      
--inner join tbl_IssueOrder tos on tv.issueorderid=tos.issueorderid      
--where tos.orderstatusid=1     
    
--group by IssusevoucherName,tv.Active  ,tv.issueorderid    
      
-- order by 1 desc     
     
     SELECT   
 (select top 1 Id from tblIssueVoucherDetail where IssueVoucherName=tv.IssueVoucherId ) as Id,  
     (select top 1 CreateDate from tblIssueVoucherVehicleDetail where IssueVoucherId=tv.IssueVoucherId ) as CreateDate,  
tv.IssueVoucherId as IssusevoucherName,  
sum(issuequantity)  as Qty,tv.dateofgenration,(Select Category_Name from CategoryMaster where id=tv.Cat_ID) as Category_Name,  
(CASE WHEN tv.Active = 1 THEN 'Active' WHEN tv.Active = 0 THEN 'InActive' END)As Status1   ,tos.IDTICTAWS,tv.Active
FROM tblIssueVoucherVehicleDetail tv    
inner join tbl_IssueOrder tos on tv.issueorderid=tos.issueorderid    
where tos.orderstatusid=1   
group by tv.IssueVoucherId,tv.Active  ,tv.issueorderid,tv.Cat_ID,tv.dateofgenration ,tos.IDTICTAWS 
order by 1 desc   

        
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getissuevoucherNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getissuevoucherNumber]
(
@issueorderid int,
@CatId int
)
As

BEGIN

select * from tbl_issuevoucherdetail tv inner join tbl_IssueOrder tos on tv.IssueorderId=tos.IssueOrderId 
where tos.IssueOrderId=@issueorderid and tv.cat_id=@CatId and tv.Active=1

END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetIssueVoucherProductByVehicle]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetIssueVoucherProductByVehicle]      
(      
@Id int=0    
      
)      
      
AS      
      
BEGIN      
      
    select      
     
    sum(StockQuantity) as Qty,pm.Product_ID,pm.Product_Name,pm.productUnit
 
  
from tblIssueVoucherVehicleDetail tv      
inner join productmaster pm on pm.product_id=tv.productid      
inner join tbl_IssueOrder tso on tv.issueorderid=tso.IssueOrderId     
inner join BatchMaster bm on bm.BID=tv.BID     
    
where tv.VehicleNo=(select top 1 tb.VechileNumber  from tbl_vechileMaster tb where tb.Id=@Id) 
group by tv.Id,tv.IssueVoucherId,tv.ProductId,tv.VehicleNo,pm.Product_ID,pm.Product_Name,pm.productUnit
  
     
      
END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetIssuevoucherQuantity_Batchwise]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_GetIssuevoucherQuantity_Batchwise]
(
@productID int,
@issueorderid int

)

As
Begin

select distinct  StockQuantity from tbl_batchIdt tb inner join tblIssueVoucherVehicleDetail tv on  tb.ProductID=tv.ProductId and tb.IssueOrderId=tv.issueorderID
where tv.issueorderID=@issueorderid and tv.ProductId=@productID

End


GO
/****** Object:  StoredProcedure [dbo].[usp_GetIssueVoucherToPrint]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetIssueVoucherToPrint]    
(    
@Id int=0  ,
@ivNo varchar(50)=''
    
)    
    
AS    
    
BEGIN    
    
--    select    
--  sum(pm.Product_ID) as PID, (bm.StockId) as SID,   
--(select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= tv.issueorderid and q.IssueVoucherId=tv.IssueVoucherId)  as sumQty,    
--'' as Remarks,  
--(select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= tv.issueorderid and q.ProductId=tv.ProductId)  as stockquantity, tso.IDTICTAWS, 
--  bm.BatchNo,
--   REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 104), '.','/')  as DOM,
--   ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.ESL, 104), '.','/')),'N/A') as ESL,
--   (bm.WeightofParticular*tv.StockQuantity) as vWeight,tv.FormatFull, tv.FormatLoose,
--  (bm.CostOfParticular*tv.StockQuantity) as vCost,tv.productid as ProductId,pm.product_name, pm.productunit,  tv.IssueVoucherId,  
--(select top 1 isnull('AT No: '+sm.ATNo,'SO No: '+sm.SupplierNo) from StockMaster sm where sm.SID=bm.StockId) as ATSONo,
----(select top 1 q.Id from tblIssueVoucherVehicleDetail q where q.issueorderid= tv.issueorderid and q.ProductId=tv.ProductId)  as Id,    
--tso.Authority,tv.through,  
--(select c.Category_Name from CategoryMaster c where c.ID=tv.Cat_ID) as Cat,tv.dateofgenration,  
--(select d.DepotNo from DepuMaster d where d.Depu_Id=tso.DepotId) as UnitNo
--from tblIssueVoucherVehicleDetail tv    
--inner join BatchMaster bm on bm.BID=tv.BID   
--inner join productmaster pm on pm.product_id=tv.productid    
--inner join tbl_IssueOrder tso on tv.issueorderid=tso.IssueOrderId   
--where IssueVoucherId= (select top 1 IssueVoucherId from tblIssueVoucherVehicleDetail where Id=@Id)    
----where IssueVoucherId= (select top 1 IssueVoucherId from tblIssueVoucherVehicleDetail where Id=13)   
--group by tv.IssueVoucherId, tv.productid,tv.through,product_name,productUnit ,tso.Authority,tv.Cat_ID,tv.dateofgenration,tso.DepotId, bm.MFGDate, bm.Esl,  
--bm.BatchNo,bm.WeightofParticular,bm.CostOfParticular,bm.StockId ,tv.StockQuantity ,tv.issueorderID,tso.IDTICTAWS,tv.FormatFull,tv.FormatLoose  
--    order by bm.StockId 

set @ivNo=(select IssueVoucherName From tblIssueVoucherDetail where Id=@Id)
     select 
     (pm.Product_ID) as PID, (bm.StockId) as SID, 
     (select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= ivD.issueorderid and q.IssueVoucherId=ivD.IssueVoucherId and q.VehicleId=ivD.VehicleId)  as sumQty,    
     ivD.VoucherRemarks  as Remarks, 
     (select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= ivD.issueorderid and q.ProductId=ivD.ProductId and q.VehicleId=ivD.VehicleId)  as stockquantity,
      iod.IDTICTAWS, 
       bm.BatchNo,
   REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 104), '.','/')  as DOM,
   ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.ESL, 104), '.','/')),'N/A') as ESL,
   REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 104), '.','/')  as ExpiryDate,
   (bm.WeightofParticular*ivD.StockQuantity) as vWeight,ivD.FormatFull, ivd.FormatLoose,
   (bm.CostOfParticular*ivD.StockQuantity) as vCost,ivD.productid as ProductId,pm.product_name, pm.productunit,  ivD.IssueVoucherId,  
    (select top 1 isnull('AT No: '+sm.ATNo,'SO No: '+sm.SupplierNo) from StockMaster sm where sm.SID=bm.StockId) as ATSONo,
    iod.Authority,ivD.through,  
(select c.Category_Name from CategoryMaster c where c.ID=ivD.Cat_ID) as Cat,ivD.dateofgenration,  
(select d.DepotNo from DepuMaster d where d.Depu_Id=iod.DepotId) as UnitNo,ivD.VehicleId
    from tblIssueVoucherVehicleDetail ivD 
     inner join ProductMaster as pm on ivD.ProductId=pm.Product_ID   
     inner join BatchMaster as bm on bm.BID=ivD.BID           
     inner join tbl_vechileMaster v on v.Id=ivD.VehicleId
     inner join CategoryMaster cat on cat.ID=ivD.Cat_ID
     inner join tbl_IssueOrder iod on iod.ID=ivD.issueorderID        
     where ivD.Active=1 and ivD.IssueVoucherId=@ivNo
     group by ivD.VehicleId, iod.Authority,ivD.Through,ivD.dateofgenration,bm.EXPDate, iod.DepotId,ivD.Cat_ID, bm.StockId,ivD.Id,pm.Product_ID,ivD.issueorderID,ivD.IssueVoucherId,ivD.VoucherRemarks,ivD.ProductId,iod.IDTICTAWS,bm.batchno,bm.MFGDate,bm.Esl,bm.WeightofParticular,ivD.StockQuantity,ivD.FormatFull,ivD.FormatLoose,bm.CostOfParticular,pm.Product_Name,pm.productUnit   
     order by bm.StockId 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetIssueVoucherVehicle]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetIssueVoucherVehicle]      
(      
@Id int=0,    
@ivNo varchar(50)=''    
      
)      
      
AS      
      
BEGIN      
      
  set @ivNo=(select IssueVoucherName From tblIssueVoucherDetail where Id=@Id)    
    select     
     v.LicenseNo, 
     tv.VehicleNo,v.DriverName,v.ArmyNo,v.Rank,    
    (select tp.Vtypename from tbl_vechileMaster_Type tp where tp.VtypeId=v.vechileType) as Type,v.Through,v.Id    
     
from tblIssueVoucherVehicleDetail tv     
inner join tbl_vechileMaster v on v.VechileNumber=tv.VehicleNo     
    
--where IssueVoucherId= (select top 1 IssueVoucherId from tblIssueVoucherVehicleDetail where Id=@Id)      
where IssueVoucherId= @ivNo    
 group by     
    v.LicenseNo,
  tv.VehicleNo,v.DriverName,v.ArmyNo,v.Rank,v.vechileType,v.Through,v.Id    
      
END    
    

GO
/****** Object:  StoredProcedure [dbo].[usp_getIssuOrderby_BatchIDT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getIssuOrderby_BatchIDT]      
    
(      
    
@Qid int,      
    
@Did int      
    
)      
    
as      
    
      
    
begin      
    
    
    
--select    
----SUM( isnull(sum(issueqty),0)* (select bm.CostOfParticular from BatchMaster bm where bm.bid=bi.bid)) as Cost,    
     
---- sum(isnull(sum(issueqty),0)*(select bm.WeightofParticular from BatchMaster bm where bm.bid=bi.bid)) as Weight,    
    
--isnull(sum(issueqty),0) as issueqty,productid,qid,pm.product_name,productUnit     
    
--from tbl_batchIdt bi inner join       
    
--productmaster pm on bi.productid=pm.product_id    
----where depuid=@Did and qid=@Qid and pm.isactive=1 and bi.issueorder_Status=0     
--where depuid=65 and qid=1 and pm.isactive=1 and bi.issueorder_Status=0     
    
--group by  depuid,productid,qid,product_name,productUnit    
  
  
  
select   
(select Product_Name from ProductMaster where Product_ID=idt.ProductID) as ProductName,  
(select productUnit from ProductMaster where Product_ID=idt.ProductID) as AU,  
(select d.Depu_Name from DepuMaster d where d.Depu_Id=idt.DepuID) as Depot,  
(select QuarterRange from tbl_idtQty_Quarter where id=idt.Qid) as Quarter, 
* from tbl_batchIdt idt  
inner join BatchMaster bm on bm.BID=idt.BID  
where  idt.DepuID=@Did and idt.Qid=@Qid and idt.IssueOrderId=0 and idt.issueorder_Status=0  

end


GO
/****** Object:  StoredProcedure [dbo].[usp_getIssuVoucherBatches]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getIssuVoucherBatches] 
(        
@productId int=0  ,    
@ivNo varchar(50)=''  
        
)        
AS        
BEGIN      
 
     select (pm.Product_ID) as PID, (bm.StockId) as SID,     
     (select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= ivD.issueorderid and q.IssueVoucherId=ivD.IssueVoucherId and q.VehicleId=ivD.VehicleId)  as sumQty,        
     ivD.VoucherRemarks  as Remarks,     
     (select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= ivD.issueorderid and q.ProductId=ivD.ProductId and q.VehicleId=ivD.VehicleId)  as stockquantity,    
    
     pm.productUnit as IDTICTAWS,  bm.BatchNo,    
   REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 104), '.','/')  as DOM,    
   ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.ESL, 104), '.','/')),'N/A') as ESL,   
   REPLACE(CONVERT(VARCHAR(11), bm.EXPDate, 104), '.','/')  as ExpiryDate,     
   (bm.WeightofParticular*ivD.StockQuantity) as vWeight,ivD.FormatFull, ivd.FormatLoose,    
   (bm.CostOfParticular*ivD.StockQuantity) as vCost,ivD.productid as ProductId,pm.product_name, pm.productunit,  ivD.IssueVoucherId,      
    (select top 1 isnull('AT No: '+sm.ATNo,'SO No: '+sm.SupplierNo) from StockMaster sm where sm.SID=bm.StockId) as ATSONo,    
    iod.Authority,ivD.through,      
(select c.Category_Name from CategoryMaster c where c.ID=ivD.Cat_ID) as Cat,ivD.dateofgenration,      
(select d.DepotNo from DepuMaster d where d.Depu_Id=iod.DepotId) as UnitNo,ivD.VehicleId    
,v.VechileNumber,v.LicenseNo,bm.BID
    from tblIssueVoucherVehicleDetail ivD     
     inner join ProductMaster as pm on ivD.ProductId=pm.Product_ID       
     inner join BatchMaster as bm on bm.BID=ivD.BID               
     inner join tbl_vechileMaster v on v.Id=ivD.VehicleId    
     inner join CategoryMaster cat on cat.ID=ivD.Cat_ID    
     inner join tbl_IssueOrder iod on iod.ID=ivD.issueorderID            
     where ivD.Active=1 and ivD.IssueVoucherId=@ivNo and ivD.ProductId=@productId
     group by bm.BID, v.VechileNumber,v.LicenseNo, ivD.VehicleId,bm.EXPDate, iod.Authority,ivD.Through,ivD.dateofgenration,iod.DepotId,ivD.Cat_ID, bm.StockId,ivD.Id,pm.Product_ID,ivD.issueorderID,ivD.IssueVoucherId,ivD.VoucherRemarks,ivD.ProductId,iod.IDTICTAWS,bm.batchno,bm.MFGDate,bm.Esl,bm.WeightofParticular,ivD.StockQuantity,ivD.FormatFull,ivD.FormatLoose,bm.CostOfParticular,pm.Product_Name,pm.productUnit       
     order by bm.StockId     
END    

GO
/****** Object:  StoredProcedure [dbo].[usp_getisuueorder_forIssueVoucher]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getisuueorder_forIssueVoucher]      
(      
@catID int,    
@issueorderid int    
)      
      
AS      
      
BEGIN     
declare @IssueorderNo nvarchar(max)   
select @IssueorderNo=IssueOrderNo from tbl_IssueOrder where issueorderid=@issueorderid   
--select @IssueorderNo=IssueOrderNo from tbl_IssueOrder where issueorderid=1001   
  
select (select top 1 sm.PackingMaterial from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as PackingMaterial,  
(select top 1 sm.PackingMaterialFormat from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as PackingMaterialFormat,  
(select top 1 sm.IsWithoutPacking from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as IsWithoutPacking,  
(select top 1 sm.PackagingMaterialShape from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as PackagingMaterialShape,  
 (select top 1 sm.PackagingMaterialSize from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as PackagingMaterialSize,  
(select top 1 sm.ShapeUnit from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as ShapeUnit,  
(select top 1 sm.Weight from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as Weight,  
(select top 1 sm.WeigthUnit from Stockmaster sm where sm.ProductId=pm.product_id order by sm.SID desc) as WeigthUnit,  
 * from [dbo].[tbl_IssueOrder] iso      
inner join productmaster pm on iso.productid=pm.product_id      
where pm.Category_Id=@catID and iso.active=1  and IssueOrderNo=@IssueorderNo    
--where pm.Category_Id=2 and iso.active=1  and IssueOrderNo=@IssueorderNo      
END  
  
--select top 1 * from StockMaster where ProductId=39 order by SID desc


GO
/****** Object:  StoredProcedure [dbo].[usp_GetLoadTallyData]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetLoadTallyData]    
(    
@LTId int=0  
  
)    
    
AS    
    
BEGIN    
    
    
    
select   
sum(pm.Product_ID) as PID,
(bm.StockId) as SID,
(select sum(q.stockquantity) from tblIssueVoucherVehicleDetail q where q.issueorderid= tiv.issueorderid and q.VehicleNo=tiv.VehicleNo)  as sumQty,  
 
ltd.Remarks,tiv.stockquantity, iv.IDTICTAWS, bm.BatchNo,(bm.WeightofParticular*tiv.StockQuantity) as vWeight,tiv.FormatFull,tiv.FormatLoose,(bm.CostOfParticular*tiv.StockQuantity) as vCost, tiv.ProductId,  product_name ,productunit,tiv.IssueVoucherId,  
(select top 1 isnull('AT No: '+sm.ATNo,'SO No: '+sm.SupplierNo) from StockMaster sm where sm.SID=bm.StockId) as ATSONo ,
(select d.Depu_Name from DepuMaster d where d.Depu_Id=iv.DepotId) as DepotName ,
REPLACE(CONVERT(VARCHAR(11), bm.MFGDate, 104), '.','/')  as DOM,
   ISNULL((REPLACE(CONVERT(VARCHAR(11), bm.ESL, 104), '.','/')),'N/A') as ESL
from tbl_loadtallydetail ltd     
inner join tbl_loadtaly lt on lt.issueorderid=ltd.issueorderid and lt.id=ltd.LoadtallyId    
inner join tblIssueVoucherVehicleDetail tiv on ltd.issueorderid=tiv.issueorderid and ltd.vechileNo=tiv.VehicleNo    
inner join tbl_IssueOrder iv on iv.IssueorderId=ltd.issueorderid     
inner join productmaster pm on pm.product_Id=tiv.productid   
inner join BatchMaster bm on bm.BID=tiv.BID   
--where ltd.loadtallynumber=(select loadtallynumber from tbl_loadtallydetail where id=3  ) and loadtally_status=1   
where ltd.loadtallynumber=(select loadtallynumber from tbl_loadtallydetail where id=@LTId  ) and loadtally_status=1   
  
group by iv.DepotId,tiv.VehicleNo, tiv.issueorderid,ltd.Remarks,bm.StockId,iv.IDTICTAWS, tiv.ProductId  ,tiv.FormatFull,tiv.FormatLoose,  product_name ,productunit,tiv.stockquantity,tiv.IssueVoucherId,bm.BatchNo,bm.WeightofParticular,bm.CostOfParticular  ,bm.MFGDate,bm.Esl
    order by bm.StockId
  --select * from tbl_loadtaly  
  --select * from tbl_loadtallydetail  
  --select * from tblIssueVoucherVehicleDetail  
  -- select * from tbl_IssueOrder  
    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getLoadtallydetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getLoadtallydetail]  
(  
@vechileNo nvarchar(max),  
@issueorderId int  
  
)  
  
AS 
-- select top 1 * from Split('23X23','X')
  
BEGIN  
  
select  (select top 1 * from Split(tv.FormatFull,'X')) as PMQtyFull
,(select top 1 * from Split(tv.FormatLoose,'|')) as PMQtyLoose,
sm.PackingMaterial,  bm.CostOfParticular*tv.StockQuantity as Cost,bm.WeightofParticular*tv.StockQuantity as Weight,bm.WeightUnit, pm.product_name,pm.productUnit,tv.*,sm.* from tblIssueVoucherVehicleDetail tv  
inner join  productmaster pm on tv.ProductId=pm.Product_ID  
inner join BatchMaster bm on bm.BID= tv.BID
inner join StockMaster sm on sm.SID=bm.StockId
where VehicleNo=@vechileNo and issueorderID=@issueorderId and tv.active=1  
  
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getLoadTallyList]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getLoadTallyList]        
    
As        
    
        
    
BEGIN        
    
        
    
SELECT   
(select d.Depu_Name from DepuMaster d where d.Depu_Id=iv.DepotId) as DispatchTo,  
ltd.Id , tl.loadtallyNumber as LoadTallyNo,tl.vechileNo as VechileNo,    
(select vh.ArmyNo from tbl_vechileMaster vh where vh.VechileNumber=tl.vechileNo) as ArmyNo,  
(select vh.DriverName from tbl_vechileMaster vh where vh.VechileNumber=tl.vechileNo) as DriverName,    
(select ty.Vtypename from tbl_vechileMaster_Type ty where ty.VtypeId=(select vh.vechileType from tbl_vechileMaster vh where vh.VechileNumber=tl.vechileNo)) as Type,  
  (select sum(td.StockQuantity) from  tblIssueVoucherVehicleDetail td where td.VehicleNo=tl.vechileNo and td.issueorderID=tl.IssueorderId)as IssueQuantity,    
tl.Createddate,    
--iv.Authority 
ltd.Through as Through,  
ltd.UnitNo , ltd.Remarks,ltd.DateofGenration,
(CASE WHEN tl.Active = 1 THEN 'Active' WHEN tl.Active = 0 THEN 'InActive' END)As Status  from tbl_loadtaly tl  
inner join tbl_loadtallydetail ltd on ltd.LoadtallyId=tl.Id  
inner join tbl_IssueOrder iv on iv.IssueorderId=tl.IssueorderId    
where tl.loadtally_status=1   
group by ltd.DateofGenration, ltd.Remarks, ltd.UnitNo, ltd.Id,tl.loadtallyNumber ,tl.vechileNo,tl.Createddate,tl.Active,tl.IssueorderId,iv.DepotId,iv.Authority ,ltd.Through 
    
 --order by 1 desc        
    
        
    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getLoadTallyNumber]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_getLoadTallyNumber]
(
@VechileNo nvarchar(max),
@issueorderid int
)


AS

BEGIN

select * from tbl_loadtaly where vechileno=@VechileNo and issueorderid=@issueorderid and active=1

END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetLoadTallyToPrint]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GetLoadTallyToPrint]
(
@LoadtallyNumber nvarchar(max)

)

AS

BEGIN



select ltd.Id as SNo, product_name ,ltd.vechileNo,ltd.Authority,ltd.Through,productunit,tiv.stockquantity,tiv.PMQuantity from tbl_loadtallydetail ltd 
inner join tbl_loadtaly lt on lt.issueorderid=ltd.issueorderid and lt.id=ltd.LoadtallyId
inner join tblIssueVoucherVehicleDetail tiv on ltd.issueorderid=tiv.issueorderid and ltd.vechileNo=tiv.VehicleNo
inner join productmaster pm on pm.product_Id=tiv.productid
where ltd.loadtallynumber=@LoadtallyNumber and loadtally_status=1 



END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetOrderDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_GetOrderDetail]
(
@Depuid int,
@productId int,
@QuaterId int

)

AS

BEGIN

select * from tbl_IssueOrder where depotid=@Depuid and productid=@productId and QuarterId=@QuaterId and active=1

END


GO
/****** Object:  StoredProcedure [dbo].[usp_getprdDetail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getprdDetail]    
(    
@prdID int    
)    
    
AS    
  
  
BEGIN    
    
select * from productmaster  where Product_ID=@prdID
 
    
    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getproductData]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getproductData]    
(    
@productName varchar(200)=''    
    
)    
    
as    
    
begin    
    
select * from tbl_ProductIDT_Quantity  a inner join productmaster b on a.pid=b.Product_ID where a.isactive=1 
    
end


GO
/****** Object:  StoredProcedure [dbo].[usp_getRemainingIDT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getRemainingIDT]      
(      
      
@productId int,      
@depuID int,
@TypeId int  ,           
@quaterID int     
      
)      
      
AS      
      
BEGIN      
      
declare @TotalIDT int ,@TotalbatchIDT int,@RemainingIDT int      
       
   select @TotalIDT = ISNULL(SUM(TotalIDT),0)   from tblStockOutMain      
   where productid=@productId and DepotId=@depuID and QuarterId=@quaterID  and Typeid=@TypeId      
      
        
   select @TotalbatchIDT= ISNULL(SUM(issueqty),0)  from tbl_batchidt where depuid=@depuID       
   and productID=@productId and qid=@quaterID      
         
   set @RemainingIDT  = convert(int,@TotalIDT)-(@TotalbatchIDT)      
         
   select isnull((@RemainingIDT),0) as RemaingIDT      
   --return @RemainingIDT      
      
END


GO
/****** Object:  StoredProcedure [dbo].[usp_getStockQuantity]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getStockQuantity]      
(      
@prdID int      
)      
      
AS       
      
BEGIN      
--select isnull(sum(quantity),0) as StockQty,product_name,productunit  from batchmaster bm     
--inner join stockmaster sm  on sm.bid=bm.bid       
--inner join productmaster pm on bm.pid=pm.Product_ID      
--where bm.pid=@prdID and bm.isactive=1 group by product_name,productunit      
    
select (select MAX(bm.WeightofParticular) from BatchMaster bm where bm.StockId in (select SID from StockMaster where ProductId=@prdID)) as WOP,
(select sum(isnull((Quantity-IssueQty),0)) from StockMaster where ProductId=@prdID)*(select MAX(bm.WeightofParticular) from BatchMaster bm where bm.StockId in (select SID from StockMaster where ProductId=@prdID)) as TotalWeight,  
(select sum(isnull((Quantity-IssueQty),0)) from StockMaster where ProductId=@prdID)*(select top 1  bm.CostOfParticular from BatchMaster bm where bm.StockId in (select SID from StockMaster where ProductId=@prdID)) as TotalCost,
(select sum(isnull((Quantity-IssueQty),0)) from StockMaster where ProductId=@prdID) as StockQty,
pm.Product_Name,pm.productUnit,* from ProductMaster pm     
   
--inner join StockMaster sm on sm.ProductId=pm.Product_ID    
where pm.Product_ID=@prdID   
and (select sum(isnull((Quantity-IssueQty),0)) from StockMaster where ProductId=@prdID)>0
    
      
END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetVechile_Detail]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[usp_GetVechile_Detail]
As                           
Begin    
Select vm.Id, vm.Through, vm.VechileNumber, vm.DriverName, vm.Rank, vm.ArmyNo, vm.unitNo, 
 vm.LicenseNo, vt.Vtypename, vm.Remarks From tbl_vechileMaster as vm, tbl_vechileMaster_Type as vt
 where vm.vechileType = vt.VtypeId
End



GO
/****** Object:  StoredProcedure [dbo].[usp_GetVechile_DetailBySearch]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_GetVechile_DetailBySearch]                            
(                        
@Todaysdate varchar(500),    
    @VehicleNos varchar(max)  
      
)                            
As                           
Begin     
declare @firstday varchar(500),@secondday varchar(500)    
set @firstday= CONVERT(VARCHAR(12),getdate(),100)    
set @secondday= CONVERT(VARCHAR(12),getdate()+1,100)     
    
             if(@Todaysdate='')    
    begin    
      select * from tbl_vechileMaster where isactive=1 and createddate between @firstday and @secondday     
   end    
   else   if(@Todaysdate='Get')    
    begin    
      select VechileNumber as VEhicle, * from tbl_vechileMaster where isactive=1 and loadtallystatus=0    
      and VechileNumber not in (select * from Split(@VehicleNos,','))  
   end    
   else    
   begin    
   select * from tbl_vechileMaster where isactive=1 and createddate=CONVERT(VARCHAR(12),@Todaysdate,100)    
   end                 
End


GO
/****** Object:  StoredProcedure [dbo].[usp_getVechile_prdquantity]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getVechile_prdquantity]      
As      
      
Begin      
      
select   
(select ty.Vtypename from tbl_vechileMaster_Type ty where ty.VtypeId=(select vh.vechileType from tbl_vechileMaster vh where vh.VechileNumber=VehicleNo)) as DDOrCHT,  
(select vh.ArmyNo from tbl_vechileMaster vh where vh.VechileNumber=VehicleNo) as ArmyNo,  
(select vh.DriverName from tbl_vechileMaster vh where vh.VechileNumber=VehicleNo) as DriverName,  
VehicleNo,issueorderID ,sum(StockQuantity) as StockQuantity ,  
(Case isnull((select l.loadtally_status from tbl_loadtaly l where l.IssueorderId=issueorderID and l.vechileNo=VehicleNo),0)  
when 0  
then 1 else 0 end) as Status,  
(Case (select count(id) from tblIssueVoucherVehicleDetail f where f.FullOccupied=1 and f.issueorderID=tb.issueorderID and f.VehicleNo=tb.VehicleNo)  
when 0  
then 0 else 1 end)  
as FullOccupied   
from tblIssueVoucherVehicleDetail tb  
 where active=1 group by VehicleNo,issueorderID   
   
--select FullOccupied,* from tblIssueVoucherVehicleDetail where vehicleno=345  
  
End


GO
/****** Object:  StoredProcedure [dbo].[usp_getvechileAutocompete]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_getvechileAutocompete]
(

@SearchText varchar(200)=null
)
AS

BEGIN


select   VechileNumber from tbl_vechileMaster where isactive=1 and VechileNumber like '%'+@SearchText+'%' and loadtallystatus=0

END


GO
/****** Object:  StoredProcedure [dbo].[usp_getvechiledetailbatchwise]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [dbo].[tblIssueVoucherVehicleDetail] where batchno='bc-58'

create proc [dbo].[usp_getvechiledetailbatchwise]
(
@issueorderid int,
@productid int,
@batchno varchar(200)

)

AS

BEGIN

if Exists  (select count(1) from [dbo].[tblIssueVoucherVehicleDetail]  where batchno=@batchno and ProductId=@productid and issueorderID=@issueorderid)

begin

select * from tblIssueVoucherVehicleDetail where batchno=@batchno and ProductId=@productid and issueorderID=@issueorderid

end

END


GO
/****** Object:  StoredProcedure [dbo].[usp_getvechileDetailforLoadtally]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_getvechileDetailforLoadtally]
(
@VechileNo nvarchar(max)

)


AS

BEGIN

select * from tbl_vechileMaster where VechileNumber=@VechileNo  and IsActive=1

END


GO
/****** Object:  StoredProcedure [dbo].[usp_getVechiledetails]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getVechiledetails]  
(  
@productID int,
@issueorderid int    
)  
  
AS  
  
BEGIN  
  
select * from tblIssueVoucherVehicleDetail where productid=@productID and issueorderid=@issueorderid
  
END


GO
/****** Object:  StoredProcedure [dbo].[usp_grdbachwithproductqty]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_grdbachwithproductqty]              
(              
              
@BatchCode int=null              
)              
              
AS              
              
BEGIN            
              
         
          
  select  bm.StockId as SID,     
  
  ISNULL((REPLACE(CONVERT(VARCHAR(4), bm.Esl, 100)+CONVERT(VARCHAR(4), bm.Esl, 120), ' ','-'))+'','') as Esl,    
  Case isnull(bm.SampleSentQty,0) when 0   
then        
 (select sum(s.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from StockPakaging s where s.StockBatchId=bm.BID)   
 else  
 isnull((select sum(ex.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0) from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),(select sum(s.RemainingQty) from StockPakaging s where s.StockBatchId=bm.BID))

 end  
 as sQuantity,     
--  Case isnull(bm.SampleSentQty,0) when 0   
--then   
--(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
-- when 0 then (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full')   
--else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc)  
-- end )         
   
-- else  
--(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
-- when 0 then isnull((select cast(cast(ex.FormatFull as varbinary) as varchar)  from ExpenseVoucherMaster ex where ex.BatchID=bm.BID)  ,
-- (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full')   )
--else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc)  
-- end )     
  
-- end  
-- as FullPack,

  
 -- Added by Rohit 
 (select sm.PackingMaterialFormat from StockMaster as sm where sm.SID = bm.StockId) as FullPack,
-- Case isnull(bm.SampleSentQty,0) when 0   
--then   
--(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
-- when 0 then (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full')   
----else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc)  
-- --end )         
   
-- else  
--   isnull((select cast(cast(ex.FormatFull as varbinary) as varchar)  from ExpenseVoucherMaster ex where ex.BatchID=bm.BID)  ,
-- (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full'))
----else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc)  
-- end )     
  
-- end 
-- as FullPack,

 Case isnull(bm.SampleSentQty,0) when 0   
then    
(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
 when 0 then  (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose')  
else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Loose' order by idt.Id desc)  
 end )          
  
  else  
(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
 when 0 then isnull((select cast(cast(ex.FormatLoose as varbinary) as varchar)  from ExpenseVoucherMaster ex where ex.BatchID=bm.BID)  ,(select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose') )
else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Loose' order by idt.Id desc)  
 end )     
 end  
  as LoosePack,   
  Case isnull(bm.SampleSentQty,0) when 0   
then    
(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
 when 0 then  (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW')   
else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='DW' order by idt.Id desc)  
 end )          
  
 else  
(Case isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID),0)  
 when 0 then isnull((select cast(cast(ex.FormatLoose as varbinary) as varchar)  from ExpenseVoucherMaster ex where ex.BatchID=bm.BID)  , (select sp.Format from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW')   )
else (select top 1 cast(cast(idt.Format as varbinary) as varchar) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='DW' order by idt.Id desc)  
 end )  
 end  
 as DWPack,
    
-- Case isnull(bm.SampleSentQty,0) when 0   
--then    
-- isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full') ,0)  
-- -isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc),0)  
     
--  else  
--  isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Full'),0)   
--+isnull((select ex.UsedQty from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),0)  
---isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full' order by idt.Id desc),0)   
  
-- end  
--  as FullPackQty,
 
 --- Added by Rohit 
 Case isnull(bm.SampleSentQty,0) when 0   
then   
  (select sum(s.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Full'),0) from StockPakaging s where s.StockBatchId=bm.BID and s.PackagingType='Full')  
  else  
 isnull((select sum(ex.RemainingQty)-isnull((select SUM(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID  and idt.PackingType='Full'),0) from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),(select sum(s.RemainingQty) from StockPakaging s where s.StockBatchId=bm.BID  and s.PackagingType='Full'))

    end as FullPackQty,
 
 
   
  Case isnull(bm.SampleSentQty,0) when 0   
then          
 isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose') ,0)  
 -isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Loose' order by idt.Id desc),0)  
  else  
isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='Loose'),0)   
+isnull((select ex.UsedQty from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),0)  
-isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='Loose' order by idt.Id desc),0)   
  
 end as LoosePackQty,    


 Case isnull(bm.SampleSentQty,0) when 0   
then   
isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW') ,0)  
 -isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='DW' order by idt.Id desc),0)  
     else  
     isnull((select sp.RemainingQty from StockPakaging sp where sp.StockBatchId=bm.BID and sp.PackagingType='DW'),0)   
+isnull((select ex.UsedQty from ExpenseVoucherMaster ex where ex.BatchID=bm.BID),0)  
-isnull((select top 1(idt.Quantity) from IDTStockTransfer idt where idt.BatchId=bm.BID and idt.PackingType='DW' order by idt.Id desc),0)   
 end  as DWPackQty,    
   
 * from BatchMaster bm          
 inner join StockPakaging sp on sp.StockBatchId=bm.BID          
        
    where bm.BID=@BatchCode           
   --where bm.BID=8     
              
END


GO
/****** Object:  StoredProcedure [dbo].[usp_idtQty_Quarter]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_idtQty_Quarter]
(
@prdName varchar (500)='',  
@Dipuname varchar(200)='',  
@DipuIdtQty int=null,
@QuarterRange varchar(500)=''
)

as

begin

declare @pid int,@fyid int ,@Qid int,@dipuid int
declare @left_IDTqty int =null
select @dipuid=depu_id from DepuMaster where depu_name=@Dipuname
select @fyid=fyid from tbl_financialyear where isactive=1  
select @pid=product_id from productmaster where product_name=@prdName  
select @Qid=id from tbl_QuarterRange where QuarterRange=@QuarterRange and fyid=@fyid


insert into tbl_idtQty_Quarter(pid,Product_Name,Qid,QuarterRange,dipu,dipuid,IDTqty,left_IDTqty,fyid,Isactive,createddate,modifieddate) values
(@pid,@prdName,@Qid,@QuarterRange,@Dipuname,@dipuid,@DipuIdtQty,@left_IDTqty,@fyid,1,getdate(),getdate())

end


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_IssueOrder]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_IssueOrder]            
(            
@issueorderNo varchar(200)='',            
@issueorderdate datetime,            
@authority varchar(200)='',            
@depoid int=null,            
@qid int=null,         
@productid int=null,        
@issuequantity int=null,      
@userid int=null,
@IDTICTAWS varchar(50)=null,         
@intResult int=0 output              
)            
As       
      
           
BEGIN            
--declare @catid int        
            
--select @catid=Category_Id from productmaster where product_id=@productid      
declare @output1 int,@issueorderid int      
      
exec [dbo].[proc_getSeedNumber]  @issueorderNo,@output1 OUTPUT     
set @issueorderid=@output1      
      
Insert into tbl_IssueOrder values(@issueorderid,@issueorderNo,@depoid,@qid,0,1,getdate(),@userid,@authority,@issueorderdate,@productid,@issuequantity,@IDTICTAWS)          
          
update tbl_batchIdt set issueorder_Status=1,IssueOrderId=@issueorderid where DepuID=@depoid and Qid=@qid  and ProductID= @productid   and issueorder_Status=0      
          
set @intResult=1              
END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertBatchIDT]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertBatchIDT]            
(            
@BatchName nvarchar(max)='', 
@Bid int,           
@issueqty numeric(18, 0)=0,            
@depuID varchar(200)='',            
@productID varchar(200)='',        
@QuaterID int=null,
@Remarks    varchar(max)='', 
@intResult int=0 output            
            
)            
            
AS            
            
            
BEGIN       
      
--declare @Bid int      
    
--select @Bid=bid from batchmaster where BatchNo= @BatchName       
    
begin    
    
Insert into tbl_batchIdt values(@BatchName,@issueqty,@depuID,@productID,@QuaterID,getdate(),0,0,@Bid,@Remarks)      
       
set @intResult =SCOPE_IDENTITY();      
   return @intResult      
            
    end    
            
END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertPrdIdt_QTY]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertPrdIdt_QTY]
(
@prdName varchar (500)='',
@Dipuname varchar(200)='',
@DipuIdtQty int,
@intResult int output 

)

As

Begin

declare @pid int,@fyid int

select @pid=product_id from productmaster where product_name=@prdName

Insert into tbl_ProductIDT_Quantity (PID,Product_Name,Dipu,Dipuprd_IDTqty,IsActive,createddate,modifieddate)
values(@pid,@prdName,@Dipuname,@DipuIdtQty,1,getdate(),getdate())

set @intResult= 1

End


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertQuarter]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_InsertQuarter]
(
@noofMonth int
)

as

begin

declare @fyid as int,@fyidouarterrange as int
select @fyid=fyid from tbl_financialyear where isactive=1
select @fyidouarterrange = count(1) from tbl_QuarterRange where fyid=@fyid


if(@fyid<>0 and @fyidouarterrange=0 )

begin



if(@noofMonth=6)
begin



insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(6,'January-June',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(6,'July-December',@fyid,1,getdate())

end

else if(@noofMonth=4)
begin

insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(4,'January-April',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(4,'May-August',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(4,'September-December',@fyid,1,getdate())

end


else if(@noofMonth=3)
begin

insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(3,'January-March',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(3,'April-June',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(3,'July-September',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(3,'October-December',@fyid,1,getdate())


end

else if(@noofMonth=2)
begin



insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'January-February',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'March-April',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'May-June',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'July-August',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'September-October',@fyid,1,getdate())
insert into tbl_QuarterRange(QuarterRangeValue,QuarterRange,FYID,IsActive,createddate)values(2,'November-December',@fyid,1,getdate())


end


end

end


GO
/****** Object:  StoredProcedure [dbo].[usp_IssueVoucherDetail_AddUpdate]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_IssueVoucherDetail_AddUpdate]                
(        
	 @Id int
	,@IssueOrderId int
	,@IssueVoucherName varchar(50)	 
	,@DateOfGeneratation datetime 
	,@UserId int           
)                
As               
Begin      
	Declare @retrunVal int  
	if Not Exists(Select 1 from tblIssueVoucherDetail where Id=@Id And Active=1)            
	Begin        
		insert into tblIssueVoucherDetail            
		Values(@IssueOrderId,@IssueVoucherName,@DateOfGeneratation,1,Getdate(),@UserId,Getdate(),@UserId)  
		Set @retrunVal = 1            
	End            
	Else            
	Begin            
		Update tblIssueVoucherDetail Set IssueVoucherName=@IssueVoucherName, DateOfGeneratation=@DateOfGeneratation where Id=@Id      
		Set @retrunVal = 1         
	End     
	Select @retrunVal       
End


GO
/****** Object:  StoredProcedure [dbo].[usp_IssueVoucherVehicleDetail_AddUpdate]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_IssueVoucherVehicleDetail_AddUpdate] (







	@IssueVoucherId VARCHAR(500) = NULL







	,@ProductId INT = NULL







	,@BatchNo VARCHAR(50) = NULL







	,@VehicleNo VARCHAR(50) = NULL







	,@PMQuantity DECIMAL(9, 2) = NULL







	,@StockQuantity DECIMAL(36, 11) = NULL







	,@VoucherRemarks VARCHAR(MAX) = NULL







	,@UserId INT = 0







	,@dateofgenration DATETIME = NULL







	,@Through VARCHAR(500) = NULL







	,@authority VARCHAR(500) = NULL







	,@catid INT = NULL







	,@issueorderid INT = NULL







	,@FormatFull VARCHAR(MAX) = NULL







	,@FormatLoose VARCHAR(MAX) = ''







	,@LeftFormatFull VARCHAR(MAX) = NULL







	,@LeftFormatLoose VARCHAR(MAX) = NULL







	,@FullQty NUMERIC(36, 11) = NULL







	,@Case INT = 0







	,@FullOccupied INT = 0







	,@leftCurrentFormatFull VARCHAR(MAX) = NULL







	,@leftCurrentFormatLoose VARCHAR(MAX) = NULL







	,@intResult INT = 0 OUTPUT







	)







AS







BEGIN







	DECLARE @Bid INT















	SELECT @Bid = bid







	FROM batchmaster







	WHERE BatchNo = @BatchNo















	DECLARE @IssueorderNo NVARCHAR(max)















	SELECT @IssueorderNo = IssueOrderNo







	FROM tbl_IssueOrder







	WHERE issueorderid = @issueorderid















	SELECT @issueorderid=ID FROM tbl_batchIdt WHERE IssueOrderId = @issueorderid















	INSERT INTO tblIssueVoucherVehicleDetail (







		IssueVoucherId







		,ProductId







		,VehicleNo







		,PMQuantity







		,StockQuantity







		,VoucherRemarks







		,Active







		,CreateDate







		,CreatedBy







		,ModifiedDate







		,ModifiedBy







		,dateofgenration







		,Through







		,issueVoucher_status







		,Cat_ID







		,issueorderID







		,batchno







		,FormatFull







		,FormatLoose







		,BID







		,FullOccupied







		)







	VALUES (







		@IssueVoucherId







		,@ProductId







		,@VehicleNo







		,@PMQuantity







		,@StockQuantity







		,@VoucherRemarks







		,1







		,Getdate()







		,@UserId







		,Getdate()







		,@UserId







		,@dateofgenration







		,@Through







		,0







		,@catid







		,@issueorderid







		,@BatchNo







		,@FormatFull







		,@FormatLoose







		,@Bid







		,@FullOccupied







		)















	UPDATE tbl_IssueOrder







	SET orderstatusid = 1







	WHERE authority = @authority







		AND productid = @ProductId







		AND IssueOrderNo = @IssueorderNo















	IF (







			@Case = 1







			OR @Case = 3







			)







	BEGIN







		IF (@FormatLoose <> '')


		BEGIN







			







			UPDATE IDTStockTransfer







			SET CurrentQuantity = @FormatLoose







			,CurrentFormat = @leftCurrentFormatLoose







			WHERE IDTId = @issueorderid







				AND PackingType = 'Loose'







		END







		ELSE







			--Full case







		BEGIN







			UPDATE IDTStockTransfer







			SET CurrentQuantity = CurrentQuantity - @FullQty







				,CurrentFormat = @leftCurrentFormatFull







			WHERE IDTId = @issueorderid







				AND (PackingType = 'Full' OR PackingType='')

		END


	END















	IF (@Case = 2)







	BEGIN







		UPDATE IDTStockTransfer







		SET CurrentQuantity = Quantity - @StockQuantity







		WHERE IDTId = @issueorderid







			AND (PackingType = 'DW' OR PackingType = '')







	END















	IF (







			@Case = 4







			OR @Case = 5







			)







	BEGIN







		UPDATE IDTStockTransfer







		SET CurrentQuantity = Quantity - @StockQuantity







		WHERE IDTId = @issueorderid







	END















	SELECT @intResult = 1







END

GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_AddUpdate]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_AddUpdate]                      
(                      
 @QuarterId int,                  
 @ProductId int,                  
 @DepotId int,                  
 @UserId int,                  
 @IDT decimal(36,3),                  
 @IDTUpdate bit ,      
 @TypeId int,      
 @Yearvalue int           
)                      
As                     
Begin            
 Declare @retrunVal int             
 if Not Exists(Select 1 from tblStockOutMain where QuarterId=@QuarterId And ProductId=@ProductId And DepotId=@DepotId And typeid=@TypeId And yearvalue=@Yearvalue)                  
 Begin              
  insert into tblStockOutMain                  
  Select Distinct @QuarterId,ProductId,@DepotId,0,Active,Getdate(),@UserId,Getdate(),@UserId,@TypeId,@Yearvalue from tblStockOutMain            
  Where QuarterId = @QuarterId and typeid=@TypeId and yearvalue=@Yearvalue And Active=1            
  Set @retrunVal = 1                  
 End                  
 Else                  
 Begin                  
  if (@IDTUpdate=0) And Exists (Select 1 from tblStockOutMain where  QuarterId=@QuarterId And ProductId=@ProductId And DepotId=@DepotId  And typeid=@TypeId and yearvalue=@Yearvalue And Active=1)                  
  Begin                  
   Update tblStockOutMain Set TotalIDT=@IDT where QuarterId=@QuarterId And ProductId=@ProductId And DepotId=@DepotId And typeid=@TypeId and yearvalue=@Yearvalue               
   Set @retrunVal = 1               
  End                 
 End           
 Select @retrunVal             
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_Depot_Update]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_Depot_Update]                            
(                            
 @QuarterId int,                        
 @DepotId int,                        
 @UserId int,  
 @TypeId int,  
 @Yearvalue int            
)                            
As                                     
Begin    
 Declare @retrunVal int  
 if Exists(Select 1 from tblStockOutMain where QuarterId=@QuarterId And DepotId=0  And typeid=@TypeId and yearvalue=@Yearvalue And Active=1)                      
 Begin   
  Update tblStockOutMain Set DepotId = @DepotId Where QuarterId=@QuarterId And DepotId=0 And typeid=@TypeId and yearvalue=@Yearvalue  And Active=1  
  Set @retrunVal = 1              
 End  
 Else  
 Begin    
  Set @retrunVal = 0         
 End  
 Select @retrunVal As retrunVal     
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_GetDatabyQuarter]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_GetDatabyQuarter]             
(                  
 @QuarterId int ,      
 @TypeId int ,      
 @Yearvalue int           
)                  
As                 
Begin             
            
                
  CREATE TABLE #tempTblMain              
  (               
  Id int,              
  ProductId int,              
  ProductName nvarchar(50),             
  StockBalance int,            
  GSreservre int,            
  productUnit varchar(50),              
  DepotId int,              
  DepotName nvarchar(50),               
  CompleteDepot nvarchar(50),               
  TotalIDT decimal(9, 2),                
  Active bit,                
  CreateDate datetime,                
  CreatedBy int,              
  TotalUnits int              
  )              
  Declare @countUnits int               
  select @countUnits =count(distinct(DepotId)) from tblStockOutMain              
              
  Insert into #tempTblMain              
  Select               
  TSOM.Id,TSOM.ProductId,PM.Product_Name,        
  ( 
  
   ISNULL((select SUM(SM.Quantity-SM.IssueQty) from StockMaster SM     where SM.ProductId=TSOM.ProductId) ,0)   
   
    
-- INNER JOIN BatchMaster BM ON SM.BID=BM.BID and BM.IsActive=1 where BM.PID= TSOM.ProductId         
  )As StockBalance,        
  GSreservre,productUnit,TSOM.DepotId,DM.Depu_Name,DM.Depu_Name+'_'+CONVERT(varchar(10), TSOM.DepotId),              
  TSOM.TotalIDT,TSOM.Active,TSOM.CreateDate,TSOM.CreatedBy,@countUnits              
  from tblStockOutMain TSOM              
  INNER JOIN DepuMaster DM ON TSOM.DepotId=DM.Depu_Id              
  INNER JOIN ProductMaster PM ON TSOM.ProductId=PM.Product_ID  
   Where TSOM.Active=1 And TSOM.QuarterId=@QuarterId and TSOM.typeid=@TypeId and TSOM.yearvalue=@Yearvalue         
  --select * from #tempTblMain              
              
 if Exists (select 1 from #tempTblMain)          
 Begin          
  DECLARE @cols AS NVARCHAR(MAX),@query  AS NVARCHAR(MAX)              
  select @cols = STUFF              
  (              
  (              
  SELECT ',' + QUOTENAME(CompleteDepot) from #tempTblMain group by CompleteDepot order by CompleteDepot              
  FOR XML PATH(''), TYPE              
          
  ).value('.', 'NVARCHAR(MAX)') ,1,1,''              
  )              
  set @query = 'SELECT ProductId,ProductName,StockBalance --ISNULL((select SUM(SM.Quantity) from StockMaster SM     where SM.ProductId=ProductId) ,0) as Quantity    
,GSreservre,productUnit,' + @cols + ' from               
  (              
  select ProductId,ProductName,StockBalance,GSreservre,productUnit,CompleteDepot,TotalIDT from #tempTblMain              
          
  ) x              
  pivot               
  (              
  sum(TotalIDT)              
  for CompleteDepot in (' + @cols + ')              
  ) p '              
          
  --select @query              
  execute(@query);            
 End          
 Else          
 Begin          
  Declare @DepotId int = 0          
  select PM.Product_ID As ProductId,PM.Product_Name As ProductName,ISNULL((select SUM(SM.Quantity-SM.IssueQty) from StockMaster SM     where SM.ProductId=PM.Product_ID) ,0) as Quantity    
,PM.GSreservre,PM.productUnit as ProductUnit,@DepotId As D_0          
  from ProductMaster PM           
  inner join tblStockOutMain TSM On PM.Product_ID = TSM.ProductID and TSM.Active=1          
  where  PM.IsActive=1 And TSM.QuarterId=@QuarterId  And TSM.typeid=@TypeId and TSM.yearvalue= @Yearvalue           
  group by PM.Product_ID ,PM.Product_Name ,PM.StockQty,PM.GSreservre,PM.productUnit           
 End          
              
 Drop Table #tempTblMain              
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_GetDepots]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_GetDepots]           
(         
 @QuarterId int,      
 @DepotId int,       
 @NewDepot  bit,               
 @IsParent  bit ,    
 @Typeid int,    
 @Yearvalue  int  ,  
 @type varchar(50)  =''       
)             
As               
Begin        
 if (@NewDepot=1)        
 Begin    
 if(@type='IDT')    
 begin  
 select Depu_Id, Depu_Name  from DepuMaster where --IsParent=@IsParent  and 
  IsActive=1 and IDT= @type and Depu_Id not in        
  (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId and typeid=@Typeid and yearvalue=@Yearvalue)        
  
 end  else  if(@type='ICT')    
 begin  
 select Depu_Id, Depu_Name  from DepuMaster where --IsParent=@IsParent and 
  IsActive=1 and ICT= @type and Depu_Id not in        
  (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId and typeid=@Typeid and yearvalue=@Yearvalue)        
  
 end    
 else  if(@type='AWS')    
 begin  
 select Depu_Id, Depu_Name  from DepuMaster where --IsParent=@IsParent and 
  IsActive=1 and AWS= @type and Depu_Id not in        
  (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId and typeid=@Typeid and yearvalue=@Yearvalue)        
  
 end    
   End        
 Else        
 Begin        
  if(@DepotId=0)      
  Begin    
   if(@type='IDT')    
 begin  
   select Depu_Id, Depu_Name  from DepuMaster where IDT= @type and --IsParent=@IsParent and 
    IsActive=1     
  
 end  else  if(@type='ICT')    
 begin  
   select Depu_Id, Depu_Name  from DepuMaster where ICT= @type and --IsParent=@IsParent and
     IsActive=1     
  
 end    
 else  if(@type='AWS')    
 begin  
   select Depu_Id, Depu_Name  from DepuMaster where AWS= @type and --IsParent=@IsParent and 
    IsActive=1     
  
 end     
    End      
  Else      
  Begin   
  if(@type='IDT')    
 begin  
   select Depu_Id, Depu_Name  from DepuMaster where IDT= @type and --IsParent=@IsParent and 
    IsActive=1 and  Depu_Id in        
   (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId  and typeid=@Typeid and yearvalue=@Yearvalue)        
   
 end  else  if(@type='ICT')    
 begin  
    select Depu_Id, Depu_Name  from DepuMaster where ICT= @type and --IsParent=@IsParent and 
     IsActive=1 and  Depu_Id in        
   (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId  and typeid=@Typeid and yearvalue=@Yearvalue)        
   
 end    
 else  if(@type='AWS')    
 begin  
   select Depu_Id, Depu_Name  from DepuMaster where AWS= @type and --IsParent=@IsParent and 
    IsActive=1 and  Depu_Id in        
   (select DepotId from  tblStockOutMain where IsActive=1 and QuarterId = @QuarterId  and typeid=@Typeid and yearvalue=@Yearvalue)        
   
 end        
    End      
 End           
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_Product_Add]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_Product_Add]                        
(                        
 @QuarterId int,                    
 @ProductId int,                    
 @UserId int,
 @TypeId int,
 @Yearvalue int        
)                        
As                                 
Begin                
 Declare @retrunVal int             
 if Not Exists(Select 1 from tblStockOutMain where QuarterId=@QuarterId And ProductId=@ProductId And typeid=@TypeId And yearvalue=@Yearvalue And Active=1)                  
 Begin       
  DECLARE @DepotId INT = 0      
  DECLARE @TotalIDT Decimal(9,2)=0       
      
  If Exists(Select 1 from tblStockOutMain where QuarterId=@QuarterId And DepotId > 0 And typeid=@TypeId  And yearvalue=@Yearvalue And Active=1)        
  Begin      
   CREATE TABLE #Depots        
   (         
   DepotId int,        
   IsProcessed bit          
   )        
   Insert into #Depots         
   Select Distinct DepotId,0 from tblStockOutMain where QuarterId=@QuarterId And Active=1        
      
   Select * from #Depots      
   DECLARE @startFlag INT= 1        
   DECLARE @endFlag INT         
         
   Select  @endFlag = count(*) from #Depots       
   if(@endFlag>0)      
   BEGIN      
    WHILE (@startFlag <=@endFlag)        
    BEGIN        
     Set @DepotId = 0        
     Select @DepotId = DepotId from #Depots where IsProcessed = 0         
     if(@DepotId!=0)        
     Begin        
      Insert into tblStockOutMain                  
      Values (@QuarterId,@ProductId,@DepotId,0,1,Getdate(),@UserId,Getdate(),@UserId,@TypeId,@Yearvalue)        
      Update #Depots Set IsProcessed=1 Where DepotId=@DepotId        
     End        
     SET @startFlag = @startFlag + 1        
    END        
   END        
   drop table #Depots        
  End      
  Else      
  Begin      
   Set @DepotId = 0        
   Insert into tblStockOutMain                  
   Values (@QuarterId,@ProductId,@DepotId,0,1,Getdate(),@UserId,Getdate(),@UserId,@TypeId,@Yearvalue)        
  End      
  Set @retrunVal = 1           
 End         
 Else        
 Begin         
  Set @retrunVal = 0              
 End        
                
 Select @retrunVal As retrunVal      
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_Products_Get]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[usp_StockOutMain_Products_Get]
@SearchText  varchar(50)=null, 
@QuarterId int,
@TypeId int,
@Yearvalue int          
As             
Begin    
	Select * from  ProductMaster 
	where 
	Product_ID 
	Not in (
	Select 
	ProductId from tblStockOutMain 
	Where 
	QuarterId = @QuarterId 
	and Typeid=@TypeId 
	and yearvalue=@Yearvalue   
	and Active=1
	)
	AND isactive = 1
	--AND Product_Name like '%'+@SearchText+'%'
	Order by Product_Name ASC
End


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_QuarterData_AutoAdd]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_QuarterData_AutoAdd]                    
(                            
 @QuarterId int,    
 @UserId int              
)                            
As                                     
BEGIN     
		Declare @retrunVal int =0       
		Declare @PastQuarterId int =0
		Declare @typeID int =0       
		Declare @yearValue int  =0    
		Select  @PastQuarterId = QuarterId from tblQuarter where QuarterId = 2-1  
		select @PastQuarterId 
		if Not Exists(Select 1 from tblStockOutMain where QuarterId=@PastQuarterId And Active=1)                      
		Begin    
			Insert into tblStockOutMain  
			Select @QuarterId,ProductId,DepotId,0,1,Getdate(),@UserId,Getdate(),@UserId,@typeID,@yearValue from tblStockOutMain where QuarterId = @PastQuarterId  
			Set @retrunVal = 1  
		End  
		Else  
		Begin    
			Set @retrunVal =0  
		End  
		Select @retrunVal as retrunVal  
END


GO
/****** Object:  StoredProcedure [dbo].[usp_StockOutMain_Quarters_Get]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StockOutMain_Quarters_Get]    
 (
 @yearvalue int
 )        
As           
Begin  
   
	Select * from  tblQuarter where QuarterYear=@yearvalue 

End


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateIdtQty_Add]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_UpdateIdtQty_Add]      
(      
@prdid int,      
@dipuID int,      
@currentQTY int ,     
@Refrenceletter varchar(200)='',    
@RefrenceletterDate datetime,    
@remarks nvarchar(max)='' ,  
@QuaterID int,  
@TypeId int  
      
      
)      
      
as      
      
begin      
      
update tblStockOutMain set TotalIDT=TotalIDT+@currentQTY where ProductId=@prdid and DepotId=@dipuID  and QuarterId=@QuaterID and typeid=@TypeId  
    
insert into  tbl_IDTrefrence values(@prdid,@dipuID,@Refrenceletter,@RefrenceletterDate,@remarks,getdate(),@QuaterID)    
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateIdtQty_Sub]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_UpdateIdtQty_Sub]      
(      
@prdid int,      
@dipuID int,      
@currentQTY int ,     
@Refrenceletter varchar(200)='',    
@RefrenceletterDate datetime,    
@remarks nvarchar(max)='' ,  
@QuaterID int,  
@TypeId int  
      
      
)      
      
as      
      
begin      
      
update tblStockOutMain set TotalIDT=TotalIDT-@currentQTY where ProductId=@prdid and DepotId=@dipuID  and QuarterId=@QuaterID and typeid=@TypeId  
    
insert into  tbl_IDTrefrence values(@prdid,@dipuID,@Refrenceletter,@RefrenceletterDate,@remarks,getdate(),@QuaterID)    
  
end


GO
/****** Object:  StoredProcedure [dbo].[usp_VechileMaster_AddUpdate]    Script Date: 28-01-2020 20:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_VechileMaster_AddUpdate]                        

(                    

@Through varchar(500)='',

@VechileNumber varchar(500)='',

@DriverName varchar(500)='',

@ArmyRank varchar(500)='',

@ArmyNo varchar(500)='',

@unitNo varchar(500)='',

@LicenseNo varchar(500)='',

@Remarks varchar(1000)='',

@vechileType varchar(500)='',

@userId int=null,   

@intResult int=0 output             

)                        

As                       

Begin              

declare @VtypeId int        

Select @VtypeId=VtypeId from tbl_vechileMaster_Type where Vtypename=@vechileType



  insert into tbl_vechileMaster                    

  Values(@Through,@VechileNumber,@DriverName,@ArmyRank,1,Getdate(),@userId,Getdate(),@userId,0,@ArmyNo,@VtypeId,@unitNo,@LicenseNo,@Remarks)

     

  Set @intResult = 1                    

                    

             

 Select @intResult               

End


GO
