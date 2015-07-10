path = require 'path-extra'
fs = require 'fs-extra'
{relative, join} = require 'path-extra'
{$, _, $$, React, ReactBootstrap, FontAwesome, ROOT, layout} = window
{_ships, $ships, $shipTypes} = window
{Alert, Grid, Col, Input, DropdownButton, Table, MenuItem, Button} = ReactBootstrap

module.exports =
  name: 'ShipPanelPatcher'
  priority: 100
  displayName: [<FontAwesome key={0} name='edit' />, ' 舰队面板']
  description: '改变舰队信息面板的样式'
  author: 'KochiyaOcean'
  link: 'https://github.com/KochiyaOcean'
  version: '3.0.0 beta'
  reactClass: React.createClass
    getInitialState: ->
      patch: 0
    handlePatch: (e) ->
      targetIndex = path.join(ROOT, 'views', 'components', 'ship', 'parts', 'panebody.cjsx')
      targetCss = path.join(ROOT, 'views', 'components', 'ship', 'assets', 'ship.css')
      srcIndex = path.join(__dirname, "ship-#{@state.patch}", 'parts', 'panebody.cjsx')
      srcCss = path.join(__dirname, "ship-#{@state.patch}", 'assets', 'ship.css')
      fs.removeSync(targetIndex)
      fs.removeSync(targetCss)
      fs.copySync(srcIndex, targetIndex)
      fs.copySync(srcCss, targetCss)
    handleKeyChange: (e) ->
      img = document.getElementById('imgShow')
      pp = path.join(__dirname, "#{e.target.value}.png")
      img.src = pp
      @setState
        patch: e.target.value
    render: ->
      <div>
        <link rel="stylesheet" href={join(relative(ROOT, __dirname), 'assets', 'ship-panel.css')} />
        <Grid className='vertical-center'>
          <Col xs={6}><h5>样式预览</h5></Col>
        </Grid>
        <Grid className='vertical-center'>
          <Col><img src={path.join(__dirname, '0.png')} id="imgShow" /></Col>
        </Grid>
        <Grid className='vertical-center'>
          <Col xs={4}><h5>选择样式</h5></Col>
        </Grid>
        <Grid className='vertical-center'>
          <Col xs={4}>
            <Input type='select' defaultValue={@state.patch} onChange={@handleKeyChange}>
              <option value=0>默认样式</option>
              <option value=1>样式一</option>
              <option value=2>样式二</option>
            </Input>
          </Col>
          <Col xs={4}>
            <Button onClick={@handlePatch}>确认（重启生效）</Button>
          </Col>
        </Grid>
      </div>
