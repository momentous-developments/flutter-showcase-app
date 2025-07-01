import type { CardStatsType } from '@/types/pages/widgetTypes'

export const db: CardStatsType = {
  statsHorizontalWithAvatar: [
    {
      stats: '$24,983',
      title: 'Total Earning',
      avatarIcon: 'tabler-currency-dollar',
      avatarColor: 'primary'
    },
    {
      stats: '$8,647',
      title: 'Unpaid Earning',
      avatarIcon: 'tabler-gift',
      avatarColor: 'success'
    },
    {
      stats: '2,367',
      title: 'Signups',
      avatarIcon: 'tabler-users',
      avatarColor: 'error'
    },
    {
      stats: '4.5%',
      title: 'Conversion Rate',
      avatarIcon: 'tabler-infinity',
      avatarColor: 'info'
    }
  ],
  statsHorizontalWithBorder: [
    {
      title: 'On route vehicles',
      stats: 42,
      trendNumber: 18.2,
      avatarIcon: 'tabler-truck',
      color: 'primary'
    },
    {
      title: 'Vehicles with errors',
      stats: 8,
      trendNumber: -8.7,
      avatarIcon: 'tabler-alert-triangle',
      color: 'warning'
    },
    {
      title: 'Deviated from route',
      stats: 27,
      trendNumber: 4.3,
      avatarIcon: 'tabler-git-fork',
      color: 'error'
    },
    {
      title: 'Late vehicles',
      stats: 13,
      trendNumber: 2.5,
      avatarIcon: 'tabler-clock',
      color: 'info'
    }
  ],
  customerStats: [
    {
      color: 'primary',
      avatarIcon: 'tabler-currency-dollar',
      title: 'account balance',
      stats: '$7480',
      content: ' Credit Left',
      description: 'Account balance for next purchase'
    },
    {
      color: 'success',
      avatarIcon: 'tabler-gift',
      title: 'loyalty program',
      chipLabel: 'Platinum member',
      description: '3000 points to next tier'
    },
    {
      color: 'warning',
      avatarIcon: 'tabler-star',
      title: 'wishlist',
      stats: '15',
      content: 'Items in wishlist',
      description: 'Receive notifications on price drops'
    },
    {
      color: 'info',
      avatarIcon: 'tabler-crown',
      title: 'coupons',
      stats: '21',
      content: 'Coupons you win',
      description: 'Use coupon on next purchase'
    }
  ],
  statsSquare: [
    {
      avatarIcon: 'tabler-briefcase',
      avatarColor: 'error',
      avatarSize: 40,
      avatarVariant: 'rounded',
      avatarSkin: 'light',
      stats: '97.8k',
      statsTitle: 'Orders'
    },
    {
      avatarIcon: 'tabler-message-dots',
      avatarColor: 'success',
      avatarSize: 40,
      avatarVariant: 'rounded',
      avatarSkin: 'light',
      stats: '3.4k',
      statsTitle: 'Review'
    }
  ],
  statsHorizontal: [
    {
      title: 'CPU Usage',
      stats: '86%',
      avatarIcon: 'tabler-cpu',
      avatarColor: 'primary',
      avatarSize: 42,
      avatarSkin: 'light'
    },
    {
      title: 'Memory Usage',
      stats: '1.24gb',
      avatarIcon: 'tabler-server',
      avatarColor: 'success',
      avatarSize: 42,
      avatarSkin: 'light'
    },
    {
      title: 'Download Ratio',
      stats: '0.2%',
      avatarIcon: 'tabler-chart-pie-2',
      avatarColor: 'error',
      avatarSize: 42,
      avatarSkin: 'light'
    },
    {
      title: 'Issues Found',
      stats: '128',
      avatarIcon: 'tabler-alert-octagon',
      avatarColor: 'warning',
      avatarSize: 42,
      avatarSkin: 'light'
    }
  ],
  statsVertical: [
    {
      title: 'Total Profit',
      subtitle: 'Last week',
      stats: '1.28k',
      avatarIcon: 'tabler-credit-card',
      avatarColor: 'error',
      avatarSize: 44,
      avatarSkin: 'light',
      chipText: '-12.2%',
      chipColor: 'error',
      chipVariant: 'tonal'
    },
    {
      title: 'Total Sales',
      subtitle: 'Monthly',
      stats: '24.67k',
      avatarIcon: 'tabler-currency-dollar',
      avatarColor: 'success',
      avatarSize: 44,
      avatarSkin: 'light',
      chipText: '+24.5%',
      chipColor: 'success',
      chipVariant: 'tonal'
    }
  ],
  statsWithAreaChart: [
    {
      stats: '92.6k',
      chartColor: 'primary',
      avatarSize: 42,
      avatarColor: 'primary',
      avatarIcon: 'tabler-users',
      avatarSkin: 'light',
      title: 'Subscribers Gained',
      chartSeries: [{ data: [40, 4, 58, 12, 35, 10, 84] }]
    },
    {
      title: 'Quarterly Sales',
      stats: '36.5%',
      avatarSize: 42,
      avatarColor: 'error',
      avatarIcon: 'tabler-shopping-cart',
      avatarSkin: 'light',
      chartColor: 'error',
      chartSeries: [{ data: [44, 75, 24, 57, 6, 84] }]
    },
    {
      title: 'Orders Received',
      stats: '97.5k',
      avatarSize: 42,
      avatarColor: 'warning',
      avatarIcon: 'tabler-box',
      avatarSkin: 'light',
      chartColor: 'warning',
      chartSeries: [{ data: [30, 84, 11, 76, 0, 49, 9] }]
    },
    {
      title: 'Revenue Generated',
      stats: '91.8k',
      avatarSize: 42,
      avatarColor: 'success',
      avatarIcon: 'tabler-credit-card',
      avatarSkin: 'light',
      chartColor: 'success',
      chartSeries: [{ data: [6, 35, 25, 61, 32, 84, 70] }]
    }
  ]
}
