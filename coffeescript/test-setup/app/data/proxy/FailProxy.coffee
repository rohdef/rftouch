Ext.define "RfTouchTest.data.proxy.FailProxy", {
  extend: 'Ext.data.proxy.Proxy'
  
  _tries: 0
  
  config:
    timeout: 1000
    failCount: 3
  
  read: (operation, callback, scope) ->
    if this._tries < this.getFailCount()
      operation.setException("FAIL!")
      this._tries += 1
    else
      operation.setSuccessful()
    
    operation.setCompleted()
    
    if (typeof callback == 'function')
      callback.call(scope or this, operation)
}
