import { GoCpu } from 'react-icons/go';
import { useZebarStore } from '../store/zebar';
import Meter from './meter';
import { useMemo } from 'react';

export default function CpuMeter() {
    const cpu = useZebarStore((state) => state.cpu);
    const colour = useMemo(() => {
        if (cpu?.usage === undefined || cpu.usage < 50) {
            return 'bg-bar-cpu-low';
        }

        if (cpu.usage < 75) {
            return 'bg-bar-cpu-moderate';
        }

        return 'bg-bar-cpu-high';
    }, [cpu?.usage]);

    return (
        <div className="flex gap-1">
            <GoCpu className="text-bar-text " />
            <Meter percent={cpu?.usage || 0} colour={colour} />
        </div>
    );
}
