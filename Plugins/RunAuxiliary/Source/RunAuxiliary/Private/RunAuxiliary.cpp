#include "RunAuxiliary.h"
#include "RunAuxiliaryPrivatePCH.h"

DEFINE_LOG_CATEGORY(RunAuxiliary)

class FRunAuxiliary final : public IRunAuxiliary
{
public:
	/** IModuleInterface implementation */
	void StartupModule() override {}
	void ShutdownModule() override {}
};

IMPLEMENT_MODULE(FRunAuxiliary, RunAuxiliary)
