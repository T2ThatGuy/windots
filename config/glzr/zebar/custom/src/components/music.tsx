import { useEffect, useMemo, useRef, useState } from 'react';
import { useZebarStore } from '../store/zebar';
import { FaMusic } from 'react-icons/fa';

export default function MusicPlayer() {
    console.debug('MusicPlayer: Rerendering');
    const media = useZebarStore((state) => state.media);
    const title = useMemo(() => media?.session?.title, [media?.session?.title]);
    const isPlaying = useMemo(
        () => media?.session?.isPlaying,
        [media?.session?.isPlaying]
    );
    const titleRef = useRef<HTMLParagraphElement | null>(null);

    const [isScrolling, setIsScrolling] = useState(false);

    useEffect(() => {
        console.debug('MusicPlayer: Triggered scrolling check');
        setIsScrolling(false);
        const { current } = titleRef;
        if (!current) return;

        const isOverflowing = current.offsetWidth < current.scrollWidth;

        if (isOverflowing && isPlaying) {
            setIsScrolling(true);
            console.debug(`MusicPlayer: Enabling scrolling`);
        }
    }, [title, isPlaying]);

    if (!media?.session?.isPlaying) return null;

    return (
        <div className="flex gap-1 max-xl:hidden">
            <p className="hidden max-w-80">{media.session.title}</p>
            <FaMusic className="my-auto" />
            <div
                className="relative max-w-80 overflow-hidden"
                style={
                    isScrolling
                        ? {
                              maskImage:
                                  'linear-gradient(to right, transparent, black 1rem, black calc(100% - 1rem), transparent)',
                          }
                        : {}
                }
            >
                <div
                    className={
                        isScrolling
                            ? 'flex w-fit animate-marquee gap-1 ps-1'
                            : undefined
                    }
                >
                    <p ref={titleRef} className="whitespace-nowrap">
                        {media.session.title}
                    </p>
                    {isScrolling ? (
                        <p className="whitespace-nowrap">
                            {media.session.title}
                        </p>
                    ) : null}
                </div>
            </div>
        </div>
    );
}
