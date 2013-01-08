config = module.exports

config["My tests"] =
  rootPath: "../"
  environment: "browser" # or "node"
  
  resources: [
    "RfTouch/*.js"
    "RfTouch/*/*.js"
    "test-setup/app/*/*.js"
    "test-setup/app/*/*/*.js"
  ]
  
  sources: [
    "test-setup/touch/sencha-touch-all.js"
    # "test-setup/touch/microloader/development.js",
    "test-setup/app.js"
  ]
  
  tests: [
    "test/*/*-test.js"
    "test/*-test.js"
  ]