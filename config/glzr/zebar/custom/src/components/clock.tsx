import { useZebarStore } from '../store/zebar';

export default function Clock() {
    const date = useZebarStore((state) => state.date);
    return <div>{date?.formatted}</div>;
}
