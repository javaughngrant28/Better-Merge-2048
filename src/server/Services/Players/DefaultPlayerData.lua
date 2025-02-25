
export type DataTemplate = {
}

export type DataInstance = {
	LastBlockChoosen: string,
}

local DefaultPlayerData = {}

DefaultPlayerData.Instances = {
    FinishedLoading = false,
}

DefaultPlayerData.Template = {

}

function DefaultPlayerData.GetInstanceDataSyncedWithSavedData(dataStoreData: DataTemplate): DataInstance
	local dataInstance = DefaultPlayerData.Instances

	for index, value in pairs(dataStoreData) do
		if dataInstance[index] then
			dataInstance[index] = value
		end
	end

	return dataInstance
end

return DefaultPlayerData