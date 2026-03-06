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
        'accenture.com/*', // Accenture
        '*.accenture.com/*', // Accenture
        'urldefense.com/v3/*', // Microsoft Defender for Office365
        'myapps.microsoft.com/*', // Microsoft My Apps
        'wd103.myworkday.com/*', // My Workday
        'teams.microsoft.com/*', // Microsoft Teams
        'm365.cloud.microsoft:443/chat/*', // Microsoft Teams
        'statics.teams.cdn.office.net/*', // Microsoft Teams
        'forms.office.com/*', // Microsoft Forms
        'engage.cloud.microsoft/*', // Microsoft Engage
        'acnchat.peerworker.ai/*', // Peer Worker
        '401k.nissay.co.jp/*', // Nissay 401k
        'api.udacity.com/*', // Udacity
      ],
      browser: 'Microsoft Edge',
    },
  ],
} satisfies FinickyConfig;
