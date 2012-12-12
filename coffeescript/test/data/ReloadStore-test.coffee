buster.testCase "The reload store", {
  setUp: () ->
    proxyName = 'RfTouchTest.data.proxy.FailProxy'
    
    Ext.syncRequire proxyName
    this.testFailProxy = Ext.create proxyName
    
    this.reloadStore = Ext.create 'RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "Tests that the fail proxy will cause a fail without reload": (done) ->
    #expect(4).toEqual(3)
    
    # Set failproxy failcount to 0 expect success first
    this.reloadStore.on('load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(false)
      
      done()
    )
    
    this.reloadStore.load()
}