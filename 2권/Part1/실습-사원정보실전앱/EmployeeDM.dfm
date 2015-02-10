object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 186
  Width = 241
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Temp\EMPLOYEE.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 56
    Top = 24
  end
  object FDQuery1: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM EMPLOYEES')
    Left = 56
    Top = 104
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 152
    Top = 104
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 144
    Top = 24
  end
end
