Ext.define "RfTouchTest.model.Person", {
  extend: 'Ext.data.Model'
  
  config:
    fields: [
      {
        name: 'firstName'
        type: 'string'
      }
      {
        name: 'lastName'
        type: 'string'
      }
      {
        name: 'age'
        type: 'int'
      }
    ]
}
