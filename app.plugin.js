const { withDangerousMod, withPlugins } = require('@expo/config-plugins');
const fs = require('fs');
const path = require('path');

const withNativeViewIOS26 = (config) => {
  return withDangerousMod(config, [
    'ios',
    async (config) => {
      const podfilePath = path.join(config.modRequest.platformProjectRoot, 'Podfile');
      
      if (fs.existsSync(podfilePath)) {
        let podfileContent = fs.readFileSync(podfilePath, 'utf-8');
        
        // Check if already added
        if (!podfileContent.includes('native-view-ios-26')) {
          // Add pod to Podfile
          const podEntry = `
  # Native View iOS 26
  pod 'native-view-ios-26', :path => '../node_modules/native-view-ios-26'
`;
          
          // Insert before the end of the target
          podfileContent = podfileContent.replace(
            /end\s*$/m,
            `${podEntry}\nend`
          );
          
          fs.writeFileSync(podfilePath, podfileContent);
        }
      }
      
      return config;
    },
  ]);
};

module.exports = (config) => {
  return withPlugins(config, [withNativeViewIOS26]);
};
