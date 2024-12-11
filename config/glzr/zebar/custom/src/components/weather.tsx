import { useZebarStore } from '../store/zebar';

export default function Weather() {
    const weather = useZebarStore((state) => state.weather);

    return <div>{weather?.status}</div>;
}
