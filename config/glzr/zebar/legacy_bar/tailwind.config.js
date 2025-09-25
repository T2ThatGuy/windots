// Not a TS File
// eslint-disable-next-line @typescript-eslint/no-require-imports
const defaultTheme = require('tailwindcss/defaultTheme');

/** @type {import('tailwindcss').Config} */
export default {
    content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
    theme: {
        extend: {
            colors: {
                bar: {
                    bg: 'hsl(var(--bg), <alpha-value>)',
                    text: 'hsl(var(--text), <alpha-value>)',
                    border: 'hsl(var(--border), <alpha-value>)',
                    shadow: 'hsl(var(--shadow), <alpha-value>)',

                    // Icons
                    icon: 'hsl(var(--icon), <alpha-value>)',

                    // Modules
                    cpu: {
                        low: 'hsl(var(--cpu), <alpha-value>)',
                        moderate: 'hsl(var(--cpu-modr-usg), <alpha-value>)',
                        high: 'hsl(var(--cpu-high-usg), <alpha-value>)',
                    },
                    memory: {
                        low: 'hsl(var(--memory-modr-usg), <alpha-value>)',
                        moderate: 'hsl(var(--memory-modr-usg), <alpha-value>)',
                        high: 'hsl(var(--memory-modr-usg), <alpha-value>)',
                    },
                    battery: {
                        full: 'hsl(var(--battery-full), <alpha-value>)',
                        half: 'hsl(var(--battery-half), <alpha-value>)',
                        empt: 'hsl(var(--battery-empt), <alpha-value>)',
                    },
                    network: 'hsl(var(--network), <alpha-value>)',
                    weather: 'hsl(var(--weather), <alpha-value>)',
                    'tiling-direction':
                        'hsl(var(--tiling-direction), <alpha-value>)',
                    workspace: {
                        active: 'hsl(var(--ws-active), <alpha-value>)',
                        deactive: 'hsl(var(--ws-deactive), <alpha-value>)',
                    },
                    // Process
                    process: {
                        default: 'hsl(var(--process), <alpha-value>)',
                        focused: 'hsl(var(--process-focused, <alpha-value>)',
                    },
                },
                blend: {
                    30: 'color-mix(in srgb, currentColor 30%, transparent)',
                },
            },
            fontFamily: {
                sans: ['var(--font-name)', ...defaultTheme.fontFamily.sans],
            },
            fontWeight: {
                bar: 'var(--font-weight)',
            },
            fontSize: {
                bar: 'var(--font-size)',
            },
            borderRadius: {
                base: 'var(--border-radius)',
            },
            borderWidth: {
                DEFAULT: 'var(--border-size)',
            },
            margin: {
                os: 'var(--outer-margin-s)',
                ot: 'var(--outer-margin-t)',
                oe: 'var(--outer-margin-e)',
                ob: 'var(--outer-margin-b)',
            },
            height: {
                bar: 'var(--max-height)',
            },
            animation: {
                marquee: 'marquee 20s linear infinite',
            },
            keyframes: {
                marquee: {
                    '0%': { transform: 'translateX(0%)' },
                    '100%': { transform: 'translateX(-50%)' },
                },
            },
        },
    },
    safelist: ['justify-self-start', 'justify-self-center', 'justify-self-end'],
    plugins: [],
};
