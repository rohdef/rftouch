// Generated by CoffeeScript 1.3.3

buster.testCase("The reload store", {
  setUp: function() {
    this.testFailProxy = null;
    return this.reloadStore = Ext.create('RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person',
      proxy: this.testFailProxy
    });
  },
  "Simple distance (on a line)": function() {
    return expect(4).toEqual(3);
  }
});