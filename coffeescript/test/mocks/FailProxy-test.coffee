buster.testCase "FailProxy", {
  setUp: () ->
    proxyName = 'RfTouchTest.data.proxy.FailProxy'
    
    Ext.syncRequire proxyName
    this.testFailProxy = Ext.create proxyName
    
    this.normalStore = Ext.create 'Ext.data.Store', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "FailProxy fails using default settings": (done) ->
    this.normalStore.on 'load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(false)
      
      done()
    
    this.normalStore.load()
  
  "FailProxy succeeds on the 4th try using default settings": (done) ->
    tries = 0
    
    this.normalStore.on 'load', (store, records, successful, operation, opts) ->
      if tries < 3
        expect(successful).toEqual(false)
        tries += 1
        store.load()
      else
        expect(successful).toEqual(true)
        done()
    
    this.normalStore.load()
    
  "FailProxy succeeds with the first try using failcount=0": (done) ->
    this.testFailProxy.setFailCount(0)
    
    this.normalStore.on 'load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(true)
      
      done()
    
    this.normalStore.load()
  
  "FailProxy succeeds on the 3rd try using failcount=2": (done) ->
    this.testFailProxy.setFailCount(2)
    tries = 0
    
    this.normalStore.on 'load', (store, records, successful, operation, opts) ->
      if tries < 2
        expect(successful).toEqual(false)
        tries += 1
        store.load()
      else
        expect(successful).toEqual(true)
        done()
    
    this.normalStore.load()
}