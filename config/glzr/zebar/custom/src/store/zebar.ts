import { create } from 'zustand';
import {
    BatteryOutput,
    CpuOutput,
    createProviderGroup,
    DateOutput,
    GlazeWmOutput,
    MemoryOutput,
    NetworkOutput,
    ProviderGroupConfig,
    WeatherOutput,
    MediaOutput,
} from 'zebar';
import { IS_LAPTOP } from '../utils';

// State Store
interface ZebarState {
    battery: BatteryOutput | null;
    cpu: CpuOutput | null;
    date: DateOutput | null;
    glazewm: GlazeWmOutput | null;
    memory: MemoryOutput | null;
    network: NetworkOutput | null;
    weather: WeatherOutput | null;
    media: MediaOutput | null;
}

export const useZebarStore = create<ZebarState>(() => ({
    battery: {} as BatteryOutput,
    cpu: {} as CpuOutput,
    date: {} as DateOutput,
    glazewm: {} as GlazeWmOutput,
    memory: {} as MemoryOutput,
    network: {} as NetworkOutput,
    weather: {} as WeatherOutput,
    media: {} as MediaOutput,
}));

// Zebar Providers
const defaultConfig = {
    cpu: { type: 'cpu' },
    date: { type: 'date', formatting: 'HH:mm' },
    glazewm: { type: 'glazewm' },
    memory: { type: 'memory' },
    weather: { type: 'weather' },
    media: { type: 'media' },
} satisfies ProviderGroupConfig;
const laptopConfigExtra = {
    battery: { type: 'battery' },
    network: { type: 'network' },
} satisfies ProviderGroupConfig;

const groupConfig = IS_LAPTOP
    ? { ...defaultConfig, ...laptopConfigExtra }
    : defaultConfig;

const providers = createProviderGroup(groupConfig);

providers.onOutput(() => {
    useZebarStore.setState(providers.outputMap, false);
});
