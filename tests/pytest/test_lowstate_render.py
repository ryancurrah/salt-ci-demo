import salt.client
caller = salt.client.Caller()


def test_lowstate_render():
    s = caller.cmd('state.show_lowstate')
    assert isinstance(s, list)
    assert len(s) > 0
