object DataModule2: TDataModule2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 352
  Width = 302
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://api.discogs.com'
    Params = <>
    HandleRedirects = True
    Left = 56
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'query'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'page'
        Options = [poAutoCreated]
        Value = '20'
      end>
    Resource = 'database/search?q={query}&type=master&per_page={page}'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 56
    Top = 104
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 144
    Top = 104
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    RootElement = 'results'
    Left = 144
    Top = 176
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    AutoCommitUpdates = False
    Left = 144
    Top = 248
  end
end
