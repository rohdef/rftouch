buster.testCase "The reload store", {
  setUp: () ->
    proxyName = 'RfTouchTest.data.proxy.FailProxy'
    
    Ext.syncRequire proxyName
    this.testFailProxy = Ext.create proxyName
    
    this.reloadStore = Ext.create 'RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "FailProxy fails using default settings using a single reload": (done) ->
    this.reloadStore.on('load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(false)
      
      done()
    )
    
    this.reloadStore.load()
  
  "FailProxy succeeds on the 4th try using default settings": (done) ->
    done()
    
  "FailProxy succeeds with the first try using failcount=0": (done) ->
    done()
  
  "FailProxy succeeds on the 3rd try using failcount=2": (done) ->
    done()
}