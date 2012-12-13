// Generated by CoffeeScript 1.3.3

buster.testCase("ReloadStore", {
  setUp: function() {
    var proxyName;
    proxyName = 'RfTouchTest.data.proxy.FailProxy';
    Ext.syncRequire(proxyName);
    this.testFailProxy = Ext.create(proxyName);
    return this.reloadStore = Ext.create('RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person',
      proxy: this.testFailProxy
    });
  },
  "ReloadStore can succeed in first try": function(done) {
    this.testFailProxy.setFailCount(0);
    this.reloadStore.on('load', function(store, records, successful, operation, opts) {
      expect(successful).toEqual(true);
      return done();
    });
    return this.reloadStore.load();
  },
  "Bailout event is fired after 3 tries": function(done) {
    var tries;
    tries = 0;
    this.reloadStore.on('load', function(store, records, successful, operation, opts) {
      return tries += 1;
    });
    return this.reloadStore.on('bailout', function(store) {
      expect(tries).toEqual(3);
      return done();
    });
  },
  "Retrying on bailout will cause 3 new retries": function(done) {
    var tries;
    tries = 0;
    this.testFailProxy.setFailCount(6);
    this.reloadStore.on('load', function(store, records, successful, operation, opts) {
      return tries += 1;
    });
    return this.reloadStore.on('bailout', function(store) {
      if (tries === 3) {
        return store.load();
      } else {
        expect(tries).toEqual(6);
        return done();
      }
    });
  },
  "Store succeeds after 2 reload when failproxy is set to fail twice": function(done) {
    this.testFailProxy.setFailCount(2);
    return done();
  },
  "Store succeeds when retrying on bailout": function(done) {
    return done();
  },
  "Bailout event is fired every time when retries is set to 0": function(done) {
    return done();
  }
});
