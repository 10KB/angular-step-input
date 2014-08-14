angular-step-input
==================

A custom user input extracted from our inhouse framework/cms. The input is somewhat similar to a native number-input,
but it allows for default styling and custom styling overrides for specified numbers.

Brought to you by [10KB](http://10kb.nl/).

## Demo

You can find some demos on the [homepage](http://angular-step-input.10kb.nl).

## Features

- styled number input
- min/max values
- custom increment/decrement icons
- override view value as function or expression (eg to represent 0 by an x-icon)
- all overrides on a per value basis (eg display 0 in red)

## Usage & configuration

For a complete documentation check the [homepage](http://angular-step-input.10kb.nl).

Directive usage:
`<tien-step-input ng-model="foo" step-input-options="options"></tien-step-input>`

Options:
```
options = {
  decrease: 'fa fa-minus',        // font-awesome icon class
  increase: 'fa fa-plus',         // font-awesome icon class
  minValue: 0,                    // min. value
  maxValue: 999,                  // max. value
  style: 'primary',               // applied css class to wrapper element
  view_value: false,              // override default view value (function or expression)
  overrides: [                    // overrides per value
    {value: 0, style: 'danger'},
    {value: 1, view_value: '{{value * 3}}'}
  ]               
};
```

## License

angular-step-input is released under the [MIT license](http://10kb.mit-license.org/). 