import { useZebarStore } from '../store/zebar';

export default function Workspaces() {
    const glazewm = useZebarStore((store) => store.glazewm);
    console.debug(glazewm);

    return (
        <div className="flex flex-row gap-2">
            {/* {glazewm?.currentWorkspaces?.map((workspace) => (
                <span key={workspace.id}>{workspace.name}</span>
            ))} */}

            {glazewm?.currentWorkspaces?.map((workspace) => (
                <div
                    key={workspace.id}
                    className="my-auto size-4 rounded-full bg-bar-workspace-deactive transition-all duration-150 ease-out hover:size-5 hover:cursor-pointer data-[current=true]:w-8 data-[current=true]:bg-bar-workspace-active"
                    data-current={workspace.hasFocus}
                    onClick={() => {
                        glazewm.runCommand(
                            `focus --workspace ${workspace.name}`
                        );
                    }}
                />
            ))}
        </div>
    );
}
