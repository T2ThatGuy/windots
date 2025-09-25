export default function Meter({
    percent,
    colour,
}: {
    percent: number;
    colour: string;
}) {
    return (
        <span
            className="h-4 w-12 rounded-base border border-bar-border"
            style={{ width: 100 }}
        >
            <span
                className={`block h-full w-0 rounded-base ${colour}`}
                style={{
                    width: `${percent}%`,
                }}
            ></span>
        </span>
    );
}
