import salt.client
caller = salt.client.Caller()


def test_pillar_render():
    pillar = caller.cmd('pillar.items')
    assert isinstance(pillar, dict)
    assert '_errors' not in pillar

