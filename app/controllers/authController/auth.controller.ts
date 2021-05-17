import {Request, Response} from 'express';

const checkPassword = (password: string) => {
  return password === 'abcde' ? true : false;
};

const login = async (req: Request, res: Response) => {
  if (!req.body.email || !req.body.password) {
    return res.status(400).send({message: 'need email and password'});
  }

  try {
    const user = await new Promise((resolve) => {
      resolve(existingUsers.find((user) => user.email === req.body.email));
    });

    if (!user) {
      return res.status(401).send({message: `User doesn't exist`});
    }

    const match = checkPassword(req.body.password);

    if (!match) {
      return res
        .status(401)
        .send({message: 'Invalid email and passoword combination'});
    }

    return res.status(200).send();
  } catch (e) {
    console.error(e);
    res.status(500).end();
  }
};

export {login};
