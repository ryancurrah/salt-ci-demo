import salt.client
caller = salt.client.Caller()


def test_lowstate_render():
    r = caller.cmd('state.show_lowstate')
    assert isinstance(r, list)
    assert len(r) > 0
