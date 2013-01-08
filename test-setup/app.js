//<debug>
Ext.Loader.setPath({
    'Ext': 'test-setup/touch/src',
    'RfTouchTest': 'test-setup/app',
    'RfTouch': 'RfTouch'
});
//</debug>

Ext.application({
    name: 'RfTouchTest',

    requires: [
    ],

    models: ['Person'],
    stores: ['RfTouch.data.ReloadStore'],
    views: ['RfTouch.ConnectivityMap'],

    icon: {
    },

    isIconPrecomposed: true,

    startupImage: {
    },

    launch: function() {
      // Do nothing, this should only ensure correct environment
    }
});
