// Cristian Pop - https://boxophobic.com/

namespace AtmosphericHeightFog
{
    public enum FogMode
    {
        UseScriptSettings = 10,
        UsePresetSettings = 15,
        UseTimeOfDay = 20,
    }

    public enum FogAxisMode
    {
        XAxis = 0,
        YAxis = 1,
        ZAxis = 2,
    }

    public enum FogLayersMode
    {
        MultiplyDistanceAndHeight = 10,
        AdditiveDistanceAndHeight = 20,
    }
}

