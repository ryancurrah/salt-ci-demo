import salt.client
caller = salt.client.Caller()


def test_pillar_render():
    p = caller.cmd('pillar.items')
    assert isinstance(p, dict)
    assert '_errors' not in p

