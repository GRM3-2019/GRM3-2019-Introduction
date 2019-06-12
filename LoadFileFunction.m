function DEM = LoadFileFunction(FolderName, FileName)
File = fullfile(FolderName,FileName)
DEM = load(File)

