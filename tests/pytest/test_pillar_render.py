import salt.client
caller = salt.client.Caller()


def test_pillar_render():
    r = caller.cmd('pillar.items')
    print r
    assert isinstance(r, dict)
    assert '_errors' not in r

