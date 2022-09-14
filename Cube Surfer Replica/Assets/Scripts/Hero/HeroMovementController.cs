using UnityEngine;

public class HeroMovementController : MonoBehaviour
{
    [SerializeField] private HeroDataTransmitter heroDataTransmitter;

    [SerializeField] private float forwardMovementSpeed;
    [SerializeField] private float horizontalMovementSpeed;
    [SerializeField] private float horizontalLimitValue;


    private float newPositionX;


    void FixedUpdate()
    {
        SetHeroForwardMovement();
        SetHeroHorizontalMovement();
    }


    private void SetHeroForwardMovement()
    {
        transform.Translate(Vector3.down * forwardMovementSpeed * Time.fixedDeltaTime);
    }


    private void SetHeroHorizontalMovement()
    {
        newPositionX = transform.position.x + heroDataTransmitter.GetHeroHorizontalValue() * horizontalMovementSpeed * Time.fixedDeltaTime;
        newPositionX = Mathf.Clamp(newPositionX, -horizontalLimitValue, horizontalLimitValue);
        transform.position = new Vector3(newPositionX, transform.position.y, transform.position.z);
    }
}
