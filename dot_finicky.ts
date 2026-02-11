import type { FinickyConfig } from '/Applications/Finicky.app/Contents/Resources/finicky.d.ts';

export default {
  defaultBrowser: 'Arc',
  options: {
    // Hide the Finicky icon for the menu bar
    hideIcon: true,
  },
  handlers: [
    {
      match: [
        'accenture.com/*',
        '*.accenture.com/*',
        'urldefense.com/v3/*',
        'myapps.microsoft.com/*',
        'wd103.myworkday.com/*',
        '401k.nissay.co.jp/*',
        'm365.cloud.microsoft:443/chat/*',
        'teams.microsoft.com/*',
        'forms.office.com/*',
        'acnchat.peerworker.ai/*',
        'teams.microsoft.com/*',
        'api.udacity.com/*',
      ],
      browser: 'Microsoft Edge',
    },
  ],
} satisfies FinickyConfig;
