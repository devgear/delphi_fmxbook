object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 279
  Width = 316
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Temp\EMPLOYEE.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object qryEmployeeList: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT EMP_NO, EMP_NAME, EMP_DEPT, EMP_EMAIL, EMP_THUMB FROM EMP' +
        'LOYEES')
    Left = 48
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 240
    Top = 112
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 240
    Top = 32
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = qryEmployeeList
    Left = 48
    Top = 184
  end
  object qryGetEmpInfo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT EMP_NAME, EMP_DEPT'
      'FROM EMPLOYEES '
      'WHERE EMP_NO = :NO')
    Left = 136
    Top = 112
    ParamData = <
      item
        Name = 'NO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
