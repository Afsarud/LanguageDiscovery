﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Language.Discovery.PhraseService {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="PhraseService.IPhraseService")]
    public interface IPhraseService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPhraseService/Search", ReplyAction="http://tempuri.org/IPhraseService/SearchResponse")]
        string Search(Language.Discovery.Entity.SearchDTO dto);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPhraseService/Search", ReplyAction="http://tempuri.org/IPhraseService/SearchResponse")]
        System.Threading.Tasks.Task<string> SearchAsync(Language.Discovery.Entity.SearchDTO dto);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IPhraseServiceChannel : Language.Discovery.PhraseService.IPhraseService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class PhraseServiceClient : System.ServiceModel.ClientBase<Language.Discovery.PhraseService.IPhraseService>, Language.Discovery.PhraseService.IPhraseService {
        
        public PhraseServiceClient() {
        }
        
        public PhraseServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public PhraseServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PhraseServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PhraseServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string Search(Language.Discovery.Entity.SearchDTO dto) {
            return base.Channel.Search(dto);
        }
        
        public System.Threading.Tasks.Task<string> SearchAsync(Language.Discovery.Entity.SearchDTO dto) {
            return base.Channel.SearchAsync(dto);
        }
    }
}
