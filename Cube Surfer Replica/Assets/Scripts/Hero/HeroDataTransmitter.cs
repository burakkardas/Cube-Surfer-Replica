using UnityEngine;

public class HeroDataTransmitter : MonoBehaviour
{
    [SerializeField] private HeroInputController heroInputController;


    public float GetHeroHorizontalValue()
    {
        return heroInputController.HorizontalValue;
    }
}
