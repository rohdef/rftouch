buster.testCase "ReloadStore", {
  setUp: () ->
    proxyName = 'RfTouchTest.data.proxy.FailProxy'
    
    Ext.syncRequire proxyName
    this.testFailProxy = Ext.create proxyName
    
    this.reloadStore = Ext.create 'RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "ReloadStore fails on a single try": (done) ->
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(false)
      
      done()
    
    this.reloadStore.load()
}