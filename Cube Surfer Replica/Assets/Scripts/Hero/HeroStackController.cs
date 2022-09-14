using System.Collections.Generic;
using UnityEngine;

public class HeroStackController : MonoBehaviour
{
    public List<GameObject> blockList = new List<GameObject>();
    private GameObject lastBlockObject;

    private void Start()
    {
        UpdateLastBlockObject();
    }



    public void IncreaseNewBlock(GameObject _gameObject)
    {
        transform.position = new Vector3(transform.position.x, transform.position.y + 2f, transform.position.z);
        _gameObject.transform.position = new Vector3(lastBlockObject.transform.position.x, lastBlockObject.transform.position.y - 2f, lastBlockObject.transform.position.z);
        _gameObject.transform.SetParent(transform);
        blockList.Add(_gameObject);
        UpdateLastBlockObject();
    }


    public void DecreaseBlock(GameObject _gameObject)
    {
        _gameObject.transform.parent = null;
        blockList.Remove(_gameObject);
        UpdateLastBlockObject();
    }


    public void UpdateLastBlockObject()
    {
        lastBlockObject = blockList[blockList.Count - 1];
    }
}
