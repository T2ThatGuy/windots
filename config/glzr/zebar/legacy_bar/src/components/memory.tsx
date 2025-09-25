import { FaMemory } from 'react-icons/fa';
import { useZebarStore } from '../store/zebar';
import Meter from './meter';
import { useMemo } from 'react';

export default function MemoryMeter() {
    const memory = useZebarStore((state) => state.memory);
    const colour = useMemo(() => {
        if (memory?.usage === undefined || memory.usage < 50) {
            return 'bg-bar-memory-low';
        }

        if (memory.usage < 75) {
            return 'bg-bar-memory-moderate';
        }

        return 'bg-bar-memory-high';
    }, [memory?.usage]);

    return (
        <div className="flex gap-1">
            <FaMemory className="text-bar-text" />
            <Meter percent={memory?.usage || 0} colour={colour} />
        </div>
    );
}
