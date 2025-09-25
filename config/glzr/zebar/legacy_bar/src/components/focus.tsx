import { useZebarStore } from '../store/zebar';

export default function CurrentFocusText() {
    const glazewm = useZebarStore((state) => state.glazewm);

    if (glazewm?.focusedContainer?.type !== 'window') return null;
    return <div>{glazewm.focusedContainer.processName}</div>;
}
