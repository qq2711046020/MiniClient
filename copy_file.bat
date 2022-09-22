set ClientPath=D:\data\Client\Trunk\
set MiniClientPath=.\
xcopy %ClientPath%Content\Script\NetMessage\proto.lua  %MiniClientPath%Content\Script\NetMessage\ /Y
xcopy %ClientPath%Content\Script\Data\Type\Properties\ItemPropertiesConfig.lua %MiniClientPath%Content\Script\Properties\ /Y
xcopy %ClientPath%Content\Script\Data\Type\Properties\PetPropertiesConfig.lua %MiniClientPath%Content\Script\Properties\ /Y
xcopy %ClientPath%Content\Script\Data\Type\Properties\PlayerPropertiesConfig.lua  %MiniClientPath%Content\Script\Properties\ /Y
pause