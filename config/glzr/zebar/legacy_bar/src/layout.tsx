// Components
import Group from './components/group';
import Clock from './components/clock';
import Weather from './components/weather';
import MusicPlayer from './components/music';
import Workspaces from './components/workspaces';
import CurrentFocusText from './components/focus';

// Icons
import { FaWindows } from 'react-icons/fa';
import MemoryMeter from './components/memory';
import CpuMeter from './components/cpu';

export default function AppLayout() {
    return (
        <div className="mb-ob me-oe ms-os mt-ot grid h-bar grid-cols-3 items-center rounded-base border border-bar-border bg-bar-bg font-sans font-bar text-bar-text opacity-95">
            <Group alignment="start" innerClass="gap-3">
                <div className="flex p-1 text-bar-icon">
                    <FaWindows />
                </div>
                <Workspaces />
                {/* Battery (Laptop Only) */}
                <></>
            </Group>
            <Group alignment="center" innerClass="gap-3">
                {/* Tiling Direction Indicator */}
                {/* Currently active Window Icon */}
                <CurrentFocusText />
                <MusicPlayer />
            </Group>
            <Group alignment="end" innerClass="gap-2">
                {/* Network Info (Laptop Only) */}
                <Clock />
                <Weather />
                <MemoryMeter />
                <CpuMeter />
            </Group>
        </div>
    );
}
