buster.testCase "The reload store", {
  setUp: () ->
    
    this.testFailProxy = null
    
    this.reloadStore = Ext.create 'RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "Simple distance (on a line)": () ->
    expect(4).toEqual(3)
}