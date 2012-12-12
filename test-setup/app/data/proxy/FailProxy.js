// Generated by CoffeeScript 1.3.3

Ext.define("RfTouchTest.data.proxy.FailProxy", {
  extend: 'Ext.data.proxy.Proxy',
  config: {
    timeout: 1000,
    tries: 3
  },
  read: function(operation, callback, scope) {
    operation.setSuccessful();
    operation.setCompleted();
    if (typeof callback === 'function') {
      return callback.call(scope || this, operation);
    }
  }
});